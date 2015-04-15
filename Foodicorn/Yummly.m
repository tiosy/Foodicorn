//
//  Yummly.m
//  Foodicorn
//
//  Created by Justin Haar on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "Yummly.h"

@implementation Yummly

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.imageUrl = [[dictionary objectForKey:@"imageUrlsBySize"] objectForKey:@"90"];
        self.ingredients = [dictionary objectForKey:@"ingredients"];
        self.recipeId = [dictionary objectForKey:@"id"];
        self.thumbnailString = [[dictionary objectForKey:@"smallImageUrls"]objectAtIndex:0];
        self.recipeName = [dictionary objectForKey:@"recipeName"];
    }
    return self;
}

+(void)recipeArrayFromDictionaryArray:(NSString *)urlString completeHandler:(void (^)(NSArray *))complete
{
    NSString *string = [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipes?_app_id=6ad7e65d&_app_key=7754c5b595a890cdb54ca45ed4072020&requirePictures=true&maxResult=6&start=0"];
    string = [string stringByAppendingString:urlString];
    NSURL *url = [NSURL URLWithString:string];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary *recipeDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         NSMutableArray *recipes = recipeDict[@"matches"];
         NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:recipes.count];
         for (NSDictionary *dict in recipes) {
             [tempArray addObject:[[Yummly alloc]initWithDictionary:dict]];

         }
         complete(tempArray);
     }];
}

//+(void)detailedArrayFromDictionaryArray:(void(^)(NSArray *))complete
//{
//    NSURL *url = [NSURL URLWithString:@"http://api.yummly.com/v1/api/recipe/%@?_app_id=6ad7e65d &_app_key=7754c5b595a890cdb54ca45ed4072020", self.recipeId];
//
//}

@end
