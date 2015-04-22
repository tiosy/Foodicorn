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

+ (NSString *)parseClassName;

+(void) addDish:(UIImage *)imageUIImage recipeId:(NSString *)recipeId;
+ (void)retrieveFDDishWithCompletion:(void (^)(NSArray *))complete;
+ (void)retrieveOneFDDishWithCompletion:(NSString *)recipeId completionHandler:(void (^)(FDDish *))complete;

@end
