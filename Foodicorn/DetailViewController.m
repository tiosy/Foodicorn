//
//  DetailViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "Yummly.h"
#import "FDTransaction.h"
#import "FDPFUser.h"
#import "FDDish.h"

@interface DetailViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property NSDictionary *detailDictionary;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property Yummly *yummly;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Yummly detailDictionaryFromDictionary:self.recipeID completeHandler:^(Yummly *yummly) {
        self.yummly = yummly;
        self.title = self.yummly.detailRecipeName;
        self.textView.text = self.yummly.detailIngredientsString;
        self.textView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:1].CGColor;
        self.textView.layer.borderWidth = 2.0f;
        NSLog(@"RecipeId is %@", self.recipeID);

        //Converting image
        NSURL *url = [NSURL URLWithString:self.yummly.urlString360];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.imageView.image = [UIImage imageWithData:data];

        //Converting Logo Image
        NSURL *logoUrl = [NSURL URLWithString:self.yummly.detailLogoUrl];
        NSData *logoData = [NSData dataWithContentsOfURL:logoUrl];
        self.logoImageView.image = [UIImage imageWithData:logoData];
        self.logoImageView.layer.borderColor = [UIColor blueColor].CGColor;
        
    }];

    //need to write code to verify if current user liked dish
}


- (IBAction)onLikeButtonTapped:(UIButton *)sender
{
    if (![self.likeButton.backgroundColor isEqual:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:1]])
    {
        self.likeButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:1];
        [self.likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.likeButton setTitle:@"Liked" forState:UIControlStateNormal];

        FDPFUser *me = [FDPFUser currentUser];

        [FDTransaction addTransaction:me.profileThumbnailPFFile userName:me.username fdPFUser:me dishID:self.recipeID dishImage:self.imageView.image likedBy:nil transactionType:@"Current User liked dish"];

     //   [FDDish addDish:self.imageView.image username:me.username recipeId:self.recipeID];

        //add like to photo add photo to liked photos array of current userlike
    } else
    {
        [self.likeButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        [self.likeButton setTitle:@"Like" forState:UIControlStateNormal];
        self.likeButton.backgroundColor = [UIColor whiteColor];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webVC = segue.destinationViewController;
    webVC.yummly = self.yummly;
}


@end
