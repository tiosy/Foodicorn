//
//  FDUser.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDUser.h"

// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>
#import "FDUtility.h"

@implementation FDUser

@dynamic username;
@dynamic followers;


+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDUser";
}



+(void) addFollower:(NSString *)username followerUsername:(NSString *)followerUSername {

    
        //retrieve the FDUser
        PFQuery *query = [FDUser query];
        [query whereKey:@"username" equalTo:username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

            NSLog(@"====%ld",objects.count);
            if (objects.count == 0) //no such username
            {
                //if user is nill, create one
                FDUser *user = [FDUser object];
                user.username = username;
                [user addObject:followerUSername forKey:@"followers"];
                [user saveInBackground];
                
            } else {

                //retrieve the fduser
                FDUser *fduser = [objects firstObject];
                [fduser addUniqueObject:followerUSername forKey:@"followers"];
                [fduser saveInBackground];

            }

        }];
        
        
}
    







@end
