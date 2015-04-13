//
//  FDDish.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import <Parse/Parse.h>

@interface FDDish : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *fid; //use FDDish's objectId
@property (nonatomic, strong) PFFile *imagePFFile;
@property (nonatomic, strong) NSData *imageThumbnailNSData;
@property (nonatomic, strong) NSArray *comments; // mids
@property (nonatomic, strong) NSArray *likedBy; //uids
@property (nonatomic, strong) NSString *uploadedBy; //uid

+ (NSString *)parseClassName;

+(void) addDish:(UIImage *) imageUIImage username: (NSString *) username;
-(void) likeDish: (NSString *) username;
-(void) commentDish: (NSString *) uid comment:(NSString *) comment;

+ (void)retrieveFDDishWithCompletion:(void (^)(NSArray *))complete;

@end
