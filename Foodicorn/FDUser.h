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
@property (nonatomic,strong)  NSString *uid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) PFFile *profileThumbnailPFFile;
@property (nonatomic, strong) NSData *profileThumbnailNSData;

@property (nonatomic, strong) NSArray *followers; //contains FDUser
@property (nonatomic, strong) NSArray *followings; //contains FDUser
@property (nonatomic, strong) NSArray *likes; //contains FDDish

+ (NSString *)parseClassName;


//add a user
-(void) addUser:(FDUser *) user  username:(NSString *)username fullname:(NSString *) fullname;

//add user profile image
+(void) addUserProfileImage:(NSString *)username userProfileImage: (UIImage *) userProfileImage;

-(void) addFollowing: (FDUser *) followingFDUser;

@end