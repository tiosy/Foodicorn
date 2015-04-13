//
//  FDTransaction.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDTransaction.h"
// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

@implementation FDTransaction

@dynamic xtranID;
@dynamic uid;
@dynamic fid;
@dynamic type;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDTransaction";
}

+(void) addTransaction: (NSString *) uid fid:(NSString *)fid type:(NSString *) type{

    FDTransaction *xtran = [FDTransaction object];
    xtran.xtranID = xtran.objectId;
    xtran.fid = fid;
    xtran.uid = uid;
    xtran.type = type;
    [xtran saveInBackground];

}





@end
