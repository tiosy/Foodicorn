//
//  FDLike.h
//  Foodicorn
//
//  Created by tim on 4/21/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import <Parse/Parse.h>
#import "FDPFUser.h"

@interface FDLike : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *from; //use FDDish's recipeId
@property (nonatomic, strong) FDPFUser *to;

+ (NSString *)parseClassName;

+(void) addLike:(NSString *) receipeId;
//a dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *) receipeId completionHandler:(void (^)(NSArray *))complete;
//a user likes dishes
+ (void) likeDishesWithCompletion:(void (^)(NSArray *))complete;

@end