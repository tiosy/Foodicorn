//
//  FDLike.h
//  Foodicorn
//
//  Created by tim on 4/21/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import <Parse/Parse.h>
#import "FDPFUser.h"
#import "FDDish.h"

@interface FDLike : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *from; //recipeId
@property (nonatomic, strong) PFFile *imagePFfile;
@property (nonatomic, strong) FDPFUser *to;   //user

+ (NSString *)parseClassName;

+(void) addLike:(NSString *) recipeId image:(UIImage *)imageUIImage;
//a dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *)recipeId completionHandler:(void (^)(NSArray *))complete;
//a user likes dishes
+ (void) likeDishesWithCompletion:(void (^)(NSArray *))complete;
+ (void) likeDishesWithCompletion:(FDPFUser *)user completionHandler:(void (^)(NSArray *))complete;

@end