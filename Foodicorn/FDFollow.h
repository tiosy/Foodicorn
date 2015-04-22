//
//  FDFollow.h
//  Foodicorn
//
//  Created by tim on 4/22/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Parse/Parse.h>
#import "FDPFUser.h"
#import "FDDish.h"

@interface FDFollow : PFObject<PFSubclassing>


@property (nonatomic, strong) FDPFUser *from; //FDPFUser
@property (nonatomic, strong) FDPFUser *to;   //FDPFUser

+ (NSString *)parseClassName;

+(void) addFollow:(FDPFUser *) following;
+(void) removeFollow:(FDPFUser *) following;
//followings
+ (void) followingsWithCompletion:(FDPFUser *)user completionHandler:(void (^)(NSArray *))complete;
//user's followers
+ (void) followersWithCompletion:(FDPFUser *)user completionHandler:(void (^)(NSArray *))complete;

@end