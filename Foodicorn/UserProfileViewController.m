//
//  UserProfileViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "UserProfileViewController.h"
#import "LikersViewController.h"
#import "DetailViewController.h"
#import "FDFollow.h"
#import "FDPFUser.h"
#import "FDFollow.h"

@interface UserProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingsCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followersTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followingTapGesture;
@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [self.user objectForKey:@"username"];
    self.userNameLabel.text = [self.user objectForKey:@"fullName"];

    self.followersTapGesture = [UITapGestureRecognizer new];
    self.followersTapGesture.delegate = self;
    self.followersTapGesture.enabled = YES;
    self.followersLabel.userInteractionEnabled = YES;
    self.followersLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.followersLabel.layer.borderWidth = 1.0;
    self.followersLabel.layer.cornerRadius = 10;
    self.followersLabel.clipsToBounds = YES;

    self.followingTapGesture = [UITapGestureRecognizer new];
    self.followingTapGesture.delegate = self;
    self.followingTapGesture.enabled = YES;
    self.followingsLabel.userInteractionEnabled = YES;
    self.followingsLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.followingsLabel.layer.borderWidth = 1.0;
    self.followingsLabel.layer.cornerRadius = 10;
    self.followingsLabel.clipsToBounds = YES;

    self.profileImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.profileImageView.layer.borderWidth  = 1.0;
    self.profileImageView.layer.cornerRadius = 39.0;
//    self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;

    PFFile *userImageFile = self.user.profileThumbnailPFFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         if (!error) {
             UIImage *image = [UIImage imageWithData:imageData];
             self.profileImageView.image = image;

         }
     }];

    //NEED TO QUERY IN USER PROFILE IMAGE, USERNAME, FOLLOWERS, FOLLOWINGS, AND LIKED DISHES


//    FDPFUser *user = [FDPFUser ];
//    user.username = self.username;
//    self.title = user.username;

    //self.userNameLabel.text = passed user's username
    //self.followersCountLabel = passed user's followers
    //self.followingsCountLabel = passed user's followings
}

#pragma mark - UICollectionView Delegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - Button Methods
- (IBAction)onFollowButtonTapped:(UIButton *)sender
{
    if (![self.followButton.backgroundColor isEqual:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2]]) {
        self.followButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitle:@"Following" forState:UIControlStateNormal];
        //write code to show that current user followed another user
        [FDFollow addFollow:self.user];

    }else
    {
        [self.followButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        [self.followButton setTitle:@"Follow" forState:UIControlStateNormal];
        self.followButton.backgroundColor = [UIColor whiteColor];
        //write code to unfollow a user
    }
}


- (IBAction)followingTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [FDFollow followingsWithCompletion:self.user completionHandler:^(NSArray *array) {
        likersVC.usersArray = array;
    }];
//    [self performSegueWithIdentifier:@"following" sender:self];
    //write code to pass a the array of people that a user follows
}


- (IBAction)followersTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [FDFollow followersWithCompletion:self.user completionHandler:^(NSArray *array) {
        likersVC.usersArray = array;
        NSLog(@"%@", array);
    }];
//    [self performSegueWithIdentifier:@"followers" sender:self];
    //write code to pass a user's followers array to followersVC
}



@end
