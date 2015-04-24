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
#import "FDLike.h"

@interface DetailViewController () <UIGestureRecognizerDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property NSDictionary *detailDictionary;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property Yummly *yummly;
@property NSMutableArray *likedDishesArray;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *logoTapGesture;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FDPFUser *currentUser = [FDPFUser currentUser];

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

    [FDLike likedByUsersWithCompletion:self.recipeID completionHandler:^(NSArray *array) {
        self.likedDishesArray = [array mutableCopy];
        for (FDPFUser *user in self.likedDishesArray) {
            if ([user.username isEqualToString:currentUser.username]) {
                self.likeButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:1];
                [self.likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.likeButton setTitle:@"Liked" forState:UIControlStateNormal];
            }
        }
    }];

    self.logoTapGesture = [UITapGestureRecognizer new];
    self.logoTapGesture.delegate = self;
    self.logoTapGesture.enabled = YES;
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

        [FDTransaction addTransaction:me.profileThumbnailPFFile userName:me.username  dishID:self.recipeID dishImage:self.imageView.image likedBy:nil transactionType:@"Current User liked dish"];

        [FDLike addLike:self.recipeID image:self.imageView.image];

     //   [FDDish addDish:self.imageView.image username:me.username recipeId:self.recipeID];

        //add like to photo add photo to liked photos array of current userlike
    } else
    {
        [self.likeButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        [self.likeButton setTitle:@"Like" forState:UIControlStateNormal];
        self.likeButton.backgroundColor = [UIColor whiteColor];

        [FDLike likeDishesWithCompletion:^(NSArray *array) {
            NSMutableArray *dishesArray = [array mutableCopy];
            for (FDLike *likedDish in dishesArray) {
                if ([likedDish.from isEqualToString:self.recipeID]) {
                    [likedDish deleteInBackground];
                }
            }
        }];

        [FDTransaction retrieveFDTransactionWithCompletion:^(NSArray *array) {
            NSMutableArray *transactionsArray = [array mutableCopy];
            for (FDTransaction *transaction in transactionsArray) {
                if ([transaction.dishID isEqualToString:self.recipeID] && [transaction.user isEqual:[FDPFUser currentUser]]) {
                    [transaction deleteInBackground];
                }
            }
        }];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"instructions"]) {
        WebViewController *webVC = segue.destinationViewController;
        webVC.name = self.yummly.detailRecipeName;
        webVC.webUrl = self.yummly.detailInstructionsUrl;
        webVC.imageUrl = self.yummly.urlString360;
    }
    else if ([segue.identifier isEqualToString:@"logo"])
    {
        WebViewController *logoWebVC = segue.destinationViewController;
        logoWebVC.name = self.yummly.detailYummlySourceName;
        logoWebVC.webUrl = self.yummly.detailYummlySourceUrl;
        logoWebVC.imageUrl = self.yummly.urlString360;
        
    }
}

@end
