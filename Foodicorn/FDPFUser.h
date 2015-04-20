//
//  FDPFUser.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Parse/Parse.h>


//subclass of PFUser
@interface FDPFUser : PFUser<PFSubclassing>

//PFUser has email, username, password
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) PFFile *profileThumbnailPFFile;
@property (nonatomic, strong) NSData *profileThumbnailNSData;

@property (nonatomic, strong) NSArray *followers; //contains NSDictionary
@property (nonatomic, strong) NSArray *followings; //contains NSDictionary
@property (nonatomic, strong) NSArray *likes; //contains FDDish

+(void) addFollowingAndFollower:(UIImage *) profileThumbnailUIImage username:(NSString *)username fullname:(NSString *)fullname followingNSString:(NSString *) followingNSString;


@end



