//
//  FDLike.m
//  Foodicorn
//
//  Created by tim on 4/21/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FDLike.h"

// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

#import "FDPFUser.h"
#import "FDDish.h"



@implementation FDLike
@dynamic from;
@dynamic to;
@dynamic imagePFfile;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDLike";
}




//+(void) addLike:(FDDish *) fdDish{
//
//    FDLike *like = [FDLike object];
//
//    [like setObject:fdDish forKey:@"from"];
//    [like setObject:[PFUser currentUser]  forKey:@"to"];
//
//    [like saveInBackground];
//}

+(void) addLike:(NSString *) recipeId image:(UIImage *)imageUIImage{

    FDLike *like = [FDLike object];

    [like setObject:recipeId forKey:@"from"];
    [like setObject:[PFUser currentUser]  forKey:@"to"];

    //UIImage -> NSData -> PFFile -> this is the dish image
    NSData *imageNSData = UIImagePNGRepresentation(imageUIImage);
    PFFile *imagePFFile = [PFFile fileWithName:like.objectId data:imageNSData]; //use uniqe objectId as file name

    [like setObject:imagePFFile forKey:@"imagePFFile"];


    [like saveInBackground];
}



//Dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *) recipeId completionHandler:(void (^)(NSArray *))complete
{
    //set up the query on the Like table
    PFQuery *query = [FDLike query];
    [query whereKey:@"from" equalTo:recipeId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *mutArray = [NSMutableArray new];
        for(FDLike *o in objects) {

            //to get the user, we get the object with the 'to key'
            FDPFUser *user = [o objectForKey:@"to"];
            [mutArray addObject:user];
        };
        NSArray *array = [mutArray mutableCopy];
        complete(array);
    }];
}

// I like Dishes
+ (void) likeDishesWithCompletion:(void (^)(NSArray *))complete
{
    //set up the query on the Like table
    PFQuery *query = [FDLike query];
    [query whereKey:@"to" equalTo:[FDPFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        complete(objects);
    }];
}



@end
