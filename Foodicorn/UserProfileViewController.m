//
//  UserProfileViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileCollectionViewCell.h"

#import "LikersViewController.h"
#import "DetailViewController.h"

#import "FDFollow.h"
#import "FDPFUser.h"
#import "FDFollow.h"
#import "FDLike.h"

@interface UserProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followersTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followingTapGesture;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;

//collection view
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic)  NSArray *collectionArray;


@property (nonatomic) NSMutableArray *followingsArray;
@property (nonatomic) NSMutableArray *followersArray;

@end

@implementation UserProfileViewController

-(void)viewDidAppear:(BOOL)animated
{

    //# of followings
    [FDFollow followingsWithCompletion:self.user completionHandler:^(NSArray *array) {

        self.followingsArray = [array mutableCopy];


        self.followingCountLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)self.followingsArray.count];
    }];

    //# of followers
    [FDFollow followersWithCompletion:self.user completionHandler:^(NSArray *array) {
        self.followersArray = [array mutableCopy];
        self.followersCountLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)self.followersArray.count];
    }];


    //collection array
    [FDLike likeDishesWithCompletion:self.user completionHandler:^(NSArray *array) {
        self.collectionArray = array;
    }];

}

//setter
-(void)setFollowersArray:(NSMutableArray *)followersArray{
    _followersArray = followersArray;
    [self.view setNeedsDisplay];
}

//setter
-(void)setFollowingsArray:(NSMutableArray *)followingsArray{
    _followersArray = followingsArray;
    [self.view setNeedsDisplay];
}

//Setter collection array
-(void)setCollectionArray:(NSArray *)collectionArray
{
    _collectionArray = collectionArray;
    [self.collectionView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.followingsArray = [NSMutableArray new];
    self.followersArray = [NSMutableArray new];

    self.title = [self.user objectForKey:@"username"];
    self.userNameLabel.text = [self.user objectForKey:@"fullName"];

    self.followersTapGesture = [UITapGestureRecognizer new];
    self.followersTapGesture.delegate = self;
    self.followersTapGesture.enabled = YES;
    self.followersLabel.userInteractionEnabled = YES;
    self.followersLabel.textColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.followersLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.followingTapGesture = [UITapGestureRecognizer new];
    self.followingTapGesture.delegate = self;
    self.followingTapGesture.enabled = YES;
    self.followingsLabel.userInteractionEnabled = YES;
    self.followingsLabel.textColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.followingsLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.profileImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.profileImageView.layer.borderWidth  = 1.0;
    self.profileImageView.layer.cornerRadius = 39.0;
//    self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;

    self.collectionView.alwaysBounceVertical = YES;


    PFFile *userImageFile = self.user.profileThumbnailPFFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         if (!error) {
             UIImage *image = [UIImage imageWithData:imageData];
             self.profileImageView.image = image;

         }
     }];



}

#pragma mark - UICollectionView Delegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfileCollectionCell" forIndexPath:indexPath];
    FDLike *like = [self.collectionArray objectAtIndex:indexPath.row];

    PFFile *dishImageFile = [like objectForKey:@"imagePFFile"];
    NSLog(@"%@", [like objectForKey:@"imagePFFile"]);
    [dishImageFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error)
     {
         if (!error) {
             UIImage *img = [UIImage imageWithData:imageNSData];
            cell.userProfileCellImage.image = img;
         }
     }];


    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];

    FDLike *like = [self.collectionArray objectAtIndex:indexPath.row];
    detailVC.recipeID = like.from;
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
    likersVC.usersArray = self.followingsArray;
    [self.navigationController pushViewController:likersVC animated:YES];

//    [self performSegueWithIdentifier:@"following" sender:self];
    //write code to pass a the array of people that a user follows
}


- (IBAction)followersTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    likersVC.usersArray = self.followersArray;
    [self.navigationController pushViewController:likersVC animated:YES];

//    [self performSegueWithIdentifier:@"followers" sender:self];
    //write code to pass a user's followers array to followersVC
}



@end
