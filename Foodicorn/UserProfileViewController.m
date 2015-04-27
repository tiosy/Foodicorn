//
//  UserProfileViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileCollectionViewCell.h"

#import "Constants.h"

#import "LikersViewController.h"
#import "DetailViewController.h"

#import "FDPFUser.h"
#import "FDFollow.h"
#import "FDLike.h"

@interface UserProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *followersCount;
@property (weak, nonatomic) IBOutlet UIButton *followingsCount;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

//collection view
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic)  NSArray *collectionArray;

@property (nonatomic) NSMutableArray *followingsArray;
@property (nonatomic) NSMutableArray *followersArray;

@property BOOL isAddFollower;
@property BOOL isAddFollowerOriginal;
@property int totalFollowers;

@end

@implementation UserProfileViewController


-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"ok i am leaving...AddFollow? %d...origin %d",self.isAddFollower,self.isAddFollowerOriginal);
    // now update FDFollow

    if(self.isAddFollower != self.isAddFollowerOriginal){

        if(self.isAddFollower){
            [FDFollow addFollowWithCompletion:self.user completionHandler:^{
            }];
        }else{ //remove
            [FDFollow removeFollowingWithCompletion:self.user completionHandler:^{
            }];
        }

    }

}


-(void)viewDidAppear:(BOOL)animated
{

    [self calculateNumFollowers];
    [self calculateNumFollowings];

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
    self.userNameLabel.textColor=kFoodiCornNavBarColor;
    self.userNameLabel.text = [self.user objectForKey:@"fullName"];

    self.profileImageView.layer.borderColor = kFoodiCornNavBarColor.CGColor;
    self.profileImageView.layer.borderWidth  = 1.0;
    self.profileImageView.layer.cornerRadius = 39.0;
    self.profileImageView.layer.masksToBounds = YES;

    self.collectionView.alwaysBounceVertical = YES;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.minimumLineSpacing = 5.0;

    //get profile image
    PFFile *userImageFile = [self.user objectForKey:@"profileThumbnailPFFile"];
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


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.frame.size.width - 10)/3, (self.collectionView.frame.size.width - 10)/3);
}

#pragma mark - Button Methods
- (IBAction)onFollowButtonTapped:(UIButton *)sender
{
    //Just toggle locally
    if ([self.followButton.titleLabel.text isEqual:kFollow]) {

        self.followButton.backgroundColor = kFoodiCornNavBarColor;
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitle:kFollowing forState:UIControlStateNormal];

        //+1
        self.isAddFollower = YES;
        self.totalFollowers++;

        self.followersCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followersCount.titleLabel.numberOfLines=0;
        self.followersCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followersCount setTitle:[NSString stringWithFormat:@"%d\nfollowers",self.totalFollowers] forState:UIControlStateNormal];


    }else{ //unfollow

            [self.followButton setTitleColor:kFoodiCornNavBarColor forState:UIControlStateNormal];
            [self.followButton setTitle:kFollow forState:UIControlStateNormal];
            self.followButton.backgroundColor = [UIColor whiteColor];

        //-1
        self.isAddFollower = NO;
        self.totalFollowers--;
        if(self.totalFollowers<0){self.totalFollowers=0;};

        self.followersCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followersCount.titleLabel.numberOfLines=0;
        self.followersCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followersCount setTitle:[NSString stringWithFormat:@"%d\nfollowers",self.totalFollowers] forState:UIControlStateNormal];


    }



}



- (IBAction)followingButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    likersVC.usersArray = self.followingsArray;
    [self.navigationController pushViewController:likersVC animated:YES];

}

- (IBAction)followersButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    likersVC.usersArray = self.followersArray;
    [self.navigationController pushViewController:likersVC animated:YES];
}




#pragma mark - helper methods

-(void) calculateNumFollowers{

    //# of followers
    [FDFollow followersWithCompletion:self.user completionHandler:^(NSArray *array) {
        self.followersArray = [array mutableCopy];

        self.totalFollowers = (int)self.followersArray.count;

        NSString *count = [NSString stringWithFormat:@"%ld", (unsigned long)self.followersArray.count];

        self.followersCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followersCount.titleLabel.numberOfLines=0;
        self.followersCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followersCount setTitle:[NSString stringWithFormat:@"%@\nfollowers",count] forState:UIControlStateNormal];

        //check if 'me' is following this user
        FDPFUser *me = [FDPFUser currentUser];
        BOOL following = [array containsObject:me];
        if(following){

            self.isAddFollowerOriginal =YES;

            self.followButton.backgroundColor = kFoodiCornNavBarColor;
            [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.followButton setTitle:kFollowing forState:UIControlStateNormal];
        } else{

            self.isAddFollowerOriginal =NO;

            [self.followButton setTitleColor:kFoodiCornNavBarColor forState:UIControlStateNormal];
            [self.followButton setTitle:kFollow forState:UIControlStateNormal];
            self.followButton.backgroundColor = [UIColor whiteColor];
        }

        self.isAddFollower = self.isAddFollowerOriginal;

    }];
}

-(void) calculateNumFollowings{

    //# of followings
    [FDFollow followingsWithCompletion:self.user completionHandler:^(NSArray *array) {
        self.followingsArray = [array mutableCopy];
        NSString *count = [NSString stringWithFormat:@"%ld", (unsigned long)self.followingsArray.count];

        self.followingsCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followingsCount.titleLabel.numberOfLines=0;
        self.followingsCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followingsCount setTitle:[NSString stringWithFormat:@"%@\nfollowing",count] forState:UIControlStateNormal];
    }];

}









@end
