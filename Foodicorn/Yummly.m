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
        self.sourceId = [dictionary objectForKey:@"sourceDisplayName"];
    }
    return self;
}

+(void)recipeArrayFromDictionaryArray:(NSString *)urlString completeHandler:(void (^)(NSArray *))complete
{
    NSString *string = [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipes?_app_id=6ad7e65d&_app_key=7754c5b595a890cdb54ca45ed4072020&requirePictures=true&maxResult=20&start=0"];
    string = [string stringByAppendingString:urlString];

    NSLog(@"==%@==", string);
    
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


-(instancetype)initWithDetailDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        //Unpacking imageUrl Dictionary
        self.detailimageUrls = [dictionary objectForKey:@"images"];
        NSDictionary *dict = self.detailimageUrls[0];
        self.urlString360 = [[dict objectForKey:@"imageUrlsBySize"] objectForKey:@"360"];

        //Unpacking ingredients Array
        self.detailIngredients = [dictionary objectForKey:@"ingredientLines"];
        self.detailIngredientsString = [[self.detailIngredients valueForKey:@"description"] componentsJoinedByString:@"\n"];

        self.detailimageUrls = [dictionary objectForKey:@"images"];
        self.detailRecipeName = [dictionary objectForKey:@"name"];
        self.detailInstructionsUrl = [[dictionary objectForKey:@"source"] objectForKey:@"sourceRecipeUrl"];
        self.detailIngredients = [dictionary objectForKey:@"ingredientLines"];
        self.detailLogoUrl = [[dictionary objectForKey:@"attribution"] objectForKey:@"logo"];
    }
    return self;
}

+(void)detailDictionaryFromDictionary:(NSString *)recipeId completeHandler:(void (^)(Yummly *))complete
{
    NSString *string1 = @"http://api.yummly.com/v1/api/recipe/";
    NSString *string2 = recipeId;
    NSString *string3 = @"?_app_id=6ad7e65d&_app_key=7754c5b595a890cdb54ca45ed4072020";
    NSString *string4 = [NSString stringWithFormat:@"%@%@%@", string1, string2, string3];
    NSURL *url = [NSURL URLWithString:string4];

    NSLog(@"The URL String is ==%@==", string4);

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *recipeDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        Yummly *yummly = [[Yummly alloc]initWithDetailDictionary:recipeDict];

        complete(yummly);
    }];

}


@end
