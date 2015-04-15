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
@dynamic profileThumbnailImage;

+ (void)load {
    [self registerSubclass];
}

//PFUser does not use this:
//+ (NSString *)parseClassName {
//    return @"TUPFUser";
//}

@end
