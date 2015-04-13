//
//  FDTransaction.h
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Parse/Parse.h>
#import "FDDish.h"

@interface FDTransaction : PFObject<PFSubclassing>

@property NSString *xtranID;
@property NSString *uid; //user ID
@property NSString *fid; // FOOD DISH ID
@property NSString *type;


+ (NSString *)parseClassName;

+(void) addTransaction:(NSString *)uid fid:(NSString *)fid type:(NSString *)type;

@end


//PFObject:
//createdAt
//updatedAt
//ObjectId