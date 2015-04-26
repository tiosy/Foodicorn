//
//  FDFollow.m
//  Foodicorn
//
//  Created by tim on 4/22/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import "FDFollow.h"

// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

#import "FDPFUser.h"

@implementation FDFollow
@dynamic from;
@dynamic to;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDFollow";
}



+(void) addFollow:(FDPFUser *)following{

    FDFollow *follow = [FDFollow object];

    [follow setObject:[FDPFUser currentUser] forKey:@"from"];
    [follow setObject:following  forKey:@"to"];

    [follow saveInBackground];
}

+ (void) addFollowWithCompletion:(FDPFUser *)following completionHandler:(void (^)(void))complete{

    FDFollow *follow = [FDFollow object];

    [follow setObject:[FDPFUser currentUser] forKey:@"from"];
    [follow setObject:following  forKey:@"to"];

    [follow saveInBackground];

}

//remove current user's following
+ (void) removeFollowingWithCompletion:(FDPFUser *)user completionHandler:(void (^)(void))complete
{
    FDPFUser *me = [FDPFUser currentUser];
    // set up the query on the Follow table
    PFQuery *query = [FDFollow query];
    [query whereKey:@"to" equalTo:user];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        for (FDFollow *following in objects) {
            FDPFUser *theUser = [following objectForKey:@"from"];

            if([theUser isEqual:me]){

                [following deleteInBackground];
            }
        }
    }];
}


//followings
+ (void) followingsWithCompletion:(FDPFUser *)user completionHandler:(void (^)(NSArray *))complete
{
    // set up the query on the Follow table
    PFQuery *query = [FDFollow query];
    [query whereKey:@"from" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *mutArray = [NSMutableArray new];

        for (FDFollow *following in objects) {
            FDPFUser *user = [following objectForKey:@"to"];
            [user fetchIfNeededInBackground];
            [mutArray addObject:user];
        }
        NSArray *array = [mutArray mutableCopy];
        complete(array); //(it is a FDPFUser array)
    }];
}

//user's followers
+ (void) followersWithCompletion:(FDPFUser *)user completionHandler:(void (^)(NSArray *))complete
{
    // set up the query on the Follow table
    PFQuery *query = [FDFollow query];
    [query whereKey:@"to" equalTo:user];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *mutArray = [NSMutableArray new];

        for (FDFollow *following in objects) {
            FDPFUser *user = [following objectForKey:@"from"];
            [user fetchIfNeededInBackground];
            [mutArray addObject:user];
        }
        NSArray *array = [mutArray mutableCopy];
        complete(array); //(it is a FDPFUser array)
    }];}




@end