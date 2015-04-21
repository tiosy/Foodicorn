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



@implementation FDLike
@dynamic from;
@dynamic to;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDLike";
}


+(void) addLike:(NSString *) receipeId{

    //or FDDish
    // create an entry in the Follow table
    FDLike *like = [FDLike object];

//    like.from = receipeId;
//    like.to = [FDPFUser currentUser];

    [like setObject:receipeId forKey:@"from"];
    [like setObject:[PFUser currentUser]  forKey:@"to"];

    [like saveInBackground];
}

//Dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *) receipeId completionHandler:(void (^)(NSArray *))complete
{
    //        // set up the query on the Like table
    PFQuery *query = [FDLike query];
    [query whereKey:@"from" equalTo:receipeId];

    // execute the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *mutArray = [NSMutableArray new];
        for(FDLike *o in objects) {

            //            // to get the user, we get the object with the to key
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
    //        // set up the query on the Follow table
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    [query whereKey:@"to" equalTo:[FDPFUser currentUser]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *mutArray = [NSMutableArray new];
        for(FDLike *o in objects) {
            NSString *str = [o objectForKey:@"from"];
            [mutArray addObject:str];
        };
        NSArray *array = [mutArray mutableCopy];
        complete(array);
    }];
}



@end
