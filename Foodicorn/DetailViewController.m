//
//  DetailViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "DetailViewController.h"
#import "Yummly.h"

@interface DetailViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSDictionary *detailDictionary;
@property Yummly *yummly;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Yummly detailDictionaryFromDictionary:self.recipeId completeHandler:^(Yummly *yummly) {
        self.yummly = yummly;

        NSLog(@"RecipeId is %@", self.recipeId);

        //Converting image
        NSURL *url = [NSURL URLWithString:self.yummly.urlString360];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.imageView.image = [UIImage imageWithData:data];
        self.textView.text = self.yummly.detailIngredientsString;
        self.title = self.yummly.detailRecipeName;
//        NSLog(@" the ingredients are %@", self.yummly.detailIngredientsString);

    }];


}


- (IBAction)onLikeButtonTapped:(UIButton *)sender {
}



- (IBAction)onInstructionsButtonTapped:(UIButton *)sender {
}

@end
