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

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDDish";
}

/////////
/////////

+(void) addDish:(UIImage *)imageUIImage recipeId:(NSString *)recipeId {

    FDDish *dish = [FDDish object];

    //UIImage -> NSData -> PFFile -> this is the dish image
    NSData *imageNSData = UIImagePNGRepresentation(imageUIImage);
    PFFile *imagePFFile = [PFFile fileWithName:dish.objectId data:imageNSData]; //use uniqe objectId as file name

    [dish setObject:recipeId forKey:@"recipeId"];
    [dish setObject:imagePFFile  forKey:@"imagePFFile"];

    [dish saveInBackground];

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



+ (void)retrieveOneFDDishWithCompletion:(NSString *)recipeId completionHandler:(void (^)(FDDish *))complete
{
    PFQuery *query = [FDDish query];
    [query whereKey:@"recipeId" equalTo:recipeId];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.

            FDDish *fdDish = [objects firstObject];
            complete(fdDish);

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



@end




