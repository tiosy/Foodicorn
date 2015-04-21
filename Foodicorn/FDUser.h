//
//  FDUser.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


//This FDUser Class is mainly used for UI...FDPFUser takes care of signup/login jobs
#import <Parse/Parse.h>
//subclass of PFObject
@interface FDUser : PFObject<PFSubclassing>

//PFUser has email, username, password

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSArray *followers; //contains FDUser

+ (NSString *)parseClassName;



+(void) addFollower:(NSString *)username followerUsername:(NSString *)followerUSername;



@end