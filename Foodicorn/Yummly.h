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
@property NSString *sourceId;
@property NSString *thumbnailString;
@property NSString *recipeName;
@property NSString *urlText;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)recipeArrayFromDictionaryArray:(NSString *)urlString completeHandler:(void (^)(NSArray *))complete;
//+(void)detailedArrayFromDictionaryArray:(void(^)(NSArray *))complete;


@end
