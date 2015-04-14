//
//  Yummly.h
//  Foodicorn
//
//  Created by Justin Haar on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Yummly : NSObject

@property NSString *imageUrl;
@property NSArray *ingredients;
@property NSString *recipeId;
@property NSString *thumbnailString;
@property NSString *recipeName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)recipeArrayFromDictionaryArray:(void(^)(NSArray *))complete;
+(void)detailedArrayFromDictionaryArray:(void(^)(NSArray *))complete;


@end
