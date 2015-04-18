//
//  FDPFUser.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FDPFUser.h"

@implementation FDPFUser

@dynamic fullName;
@dynamic profileThumbnailPFFile;
@dynamic profileThumbnailNSData;
@dynamic followers;
@dynamic followings;
@dynamic likes;

+ (void)load {
    [self registerSubclass];
}

//PFUser does not use this:
//+ (NSString *)parseClassName {
//    return @"TUPFUser";
//}

@end
