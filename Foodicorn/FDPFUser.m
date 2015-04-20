//
//  FDPFUser.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FDPFUser.h"

@implementation FDPFUser

@dynamic fullName;
@dynamic profileThumbnailPFFile;
@dynamic profileThumbnailNSData;
@dynamic followers;
@dynamic followings;
@dynamic likes;

+ (void)load {
    [self registerSubclass];
}


+(void) addFollowingAndFollower:(UIImage *) profileThumbnailUIImage username:(NSString *)username fullname:(NSString *)fullname followingNSString:(NSString *) followingNSString{


    FDPFUser *me = [FDPFUser currentUser];

    if(me){

        // I am following this username
        NSMutableDictionary *dict = [NSMutableDictionary new];
        //userProfileImage is thumbnailed already no need to shrink)
        NSData *imageNSData = UIImagePNGRepresentation(profileThumbnailUIImage);
        if([imageNSData length] <128000){
            [dict setValue:imageNSData forKey:@"profileThumbnailNSData"];
        }
        [dict setValue:username forKey:@"username"];
        [dict setValue:fullname forKey:@"fullname"];
        [dict setValue:followingNSString forKey:@"followingNSString"]; //@"Following" or @"+ Follow"
        
        //Parse only allows NSDictionary? not mutable dict?
        NSDictionary *dict2 = [dict mutableCopy];
        [me addUniqueObject:dict2 forKey:@"followings"];
        [me saveInBackground];


        //This username has me as a follower
        PFQuery *query = [FDPFUser query];
     //   [query whereKey:@"username" equalTo:username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
            
                //retrieve the fduser
                FDPFUser *fduser = [objects firstObject];
                [fduser addUniqueObject:me.username forKey:@"followers"];
                [fduser saveInBackground];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];


    } //me

}


@end
