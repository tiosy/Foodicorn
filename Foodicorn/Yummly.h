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

@property NSArray *detailimageUrls;
@property NSString *urlString360;
@property NSString *detailRecipeName;
@property NSString *detailInstructionsUrl;
@property NSArray *detailIngredients;
@property NSString *detailIngredientsString;
@property NSString *detailLogoUrl;
@property NSString *detailYummlySourceUrl;
@property NSString *detailYummlySourceName;



-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(void)recipeArrayFromDictionaryArray:(NSString *)urlString completeHandler:(void (^)(NSArray *))complete;

-(instancetype)initWithDetailDictionary:(NSDictionary *)dictionary;
+(void)detailDictionaryFromDictionary:(NSString *)recipeId completeHandler:(void (^)(Yummly *))complete;


@end
