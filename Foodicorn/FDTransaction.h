//
//  FDTransaction.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Parse/Parse.h>


@interface FDTransaction : PFObject<PFSubclassing>

//it has 3 system generated properties: objectId, createdAt, updatedAt

@property NSData *userProfileImageNSData;
@property PFFile *userProfileImagePFFile;
@property NSString *userName;
@property NSString *dishID;
@property PFFile *dishImagePFFile;
@property NSArray *likedBy;  //each element is FDUser
@property NSString *transactionType;


+ (NSString *)parseClassName;

+(void) addTransaction:(UIImage *)userProfileImage userName:(NSString *)userName dishImage:(UIImage *)dishImage likedBy:(NSArray *)likedBy transactionType:(NSString *)transactionType;

+ (void)retrieveFDTransactionWithCompletion:(void (^)(NSArray *))complete;

@end


//PFObject:
//createdAt
//updatedAt
//ObjectId