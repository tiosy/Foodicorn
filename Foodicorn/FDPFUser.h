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
@property (nonatomic, strong) NSData *profileThumbnailImage;


//+ (NSString *)parseClassName;


@end




// NOTES:

//[FDPFUser registerSubclass];
//[FDPFUser currentUser]; //return subclass