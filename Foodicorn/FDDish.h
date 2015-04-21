//
//  FDDish.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import <Parse/Parse.h>

@interface FDDish : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *recipeId; //use FDDish's recipeId
@property (nonatomic, strong) PFFile *imagePFFile;
@property (nonatomic, strong) NSData *imageThumbnailNSData;
@property (nonatomic, strong) NSArray *comments; // mids
@property (nonatomic, strong) NSArray *likedBy; // each element is FDUser

+ (NSString *)parseClassName;

+(void) addDish:(UIImage *)imageUIImage username: (NSString *) username recipeId:(NSString *)recipeId;
+ (void)retrieveFDDishWithCompletion:(void (^)(NSArray *))complete;
+(void) addLike:(NSString *) receipeId;
//a dish liked by users
+ (void) likedByUsersWithCompletion:(NSString *) receipeId completionHandler:(void (^)(NSArray *))complete;
//a user likes dishes
+ (void) likeDishesWithCompletion:(void (^)(NSArray *))complete;

@end
