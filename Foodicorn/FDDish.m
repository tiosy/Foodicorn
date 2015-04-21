//
//  FDDish.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDDish.h"
// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

#import "FDPFUser.h"
#import "FDTransaction.h"
#import "FDUtility.h"


@implementation FDDish
@dynamic recipeId;
@dynamic imagePFFile;
@dynamic imageThumbnailNSData;
@dynamic comments;
@dynamic likedBy;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDDish";
}

+(void) addDish:(UIImage *)imageUIImage username: (NSString *) username recipeId:(NSString *)recipeId {

    FDDish *fddish = [FDDish object];
    fddish.recipeId = recipeId; //NSString

    FDPFUser *me = [FDPFUser currentUser];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    //userProfileImage is thumbnailed already no need to shrink)
    if([me.profileThumbnailNSData length] <128000){
        [dict setValue:me.profileThumbnailNSData forKey:@"profileThumbnailNSData"];
    }
    [dict setValue:me.username forKey:@"username"];
    [dict setValue:me.fullName forKey:@"fullname"];

    //Parse only allows NSDictionary? not mutable dict?
    NSDictionary *dict2 = [dict mutableCopy];
    [fddish addUniqueObject:dict2 forKey:@"likedBy"];

    //UIImage -> NSData -> PFFile -> this is the dish image
    NSData *imageNSData = UIImagePNGRepresentation(imageUIImage);
    PFFile *imagePFFile = [PFFile fileWithName:fddish.objectId data:imageNSData]; //use uniqe objectId as file name
    fddish.imagePFFile = imagePFFile;

    [fddish saveInBackground];

}



+ (void)retrieveFDDishWithCompletion:(void (^)(NSArray *))complete
{
    PFQuery *query = [FDDish query];
    //[query whereKey:@"username" equalTo:username];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.


            NSMutableArray *superDishes = [NSMutableArray arrayWithCapacity:objects.count];
            superDishes = [objects mutableCopy];
            complete(superDishes);

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



+(void) addLike:(NSString *) receipeId{

   //or FDDish
    // create an entry in the Follow table
    PFObject *like = [PFObject objectWithClassName:@"Like"];
   
    [like setObject:receipeId forKey:@"from"];
    [like setObject:[PFUser currentUser]  forKey:@"to"];
    [like setObject:[NSDate date] forKey:@"date"];
    [like saveInBackground];
}

//Dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *) receipeId completionHandler:(void (^)(NSArray *))complete
{
    //        // set up the query on the Like table
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"from" equalTo:receipeId];

    // execute the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects);
    }];
}

// I like Dishes
+ (void) likeDishesWithCompletion:(void (^)(NSArray *))complete
{
    //        // set up the query on the Follow table
            PFQuery *query = [PFQuery queryWithClassName:@"Like"];
            [query whereKey:@"to" equalTo:[FDPFUser currentUser]];
    
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

                complete(objects);

            }];
}



@end




