//
//  ProfileViewController.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/15/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "DetailViewController.h"
#import "LikersViewController.h"
#import "EditProfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingsLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followersTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followingTapGesture;
@property NSArray *collectionArray;
@property NSDictionary *collectionDict;
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //will change title to user.username
    self.title = @"My Profile";

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

    self.imageViewTapGesture = [UITapGestureRecognizer new];
    self.imageViewTapGesture.delegate = self;
    self.imageViewTapGesture.enabled = YES;
    self.profileImageView.userInteractionEnabled = YES;
    self.profileImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.profileImageView.layer.borderWidth = 1.0f;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.clipsToBounds = YES;

    self.collectionDict = @{ @"cell": @"Cell A",
                              @"userImageName": @"person",
                              @"userName": @"tylorswift",
                              @"numOfFollowers": @"5",
                              @"numOfFollowing": @"1",
                              @"collections": @[@"food1", @"food2", @"food3", @"food4", @"food5", @"food7"]
                           };

     self.collectionArray = [self.collectionDict objectForKey:@"collections"];

    NSString *userImage = [self.collectionDict objectForKey:@"userImageName"];
    self.profileImageView.image =[UIImage imageNamed:userImage];
    self.userNameLabel.text = [self.collectionDict objectForKey:@"userName"];
    self.followersCountLabel.text =[self.collectionDict objectForKey:@"numOfFollowers"];
    self.followingCountLabel.text =[self.collectionDict objectForKey:@"numOfFollowing"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    NSString *cellImage = [self.collectionArray objectAtIndex:indexPath.row];
    cell.profileCellImage.image = [UIImage imageNamed:cellImage];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
    //write code here to pass yummly recipe to detail
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //write code in here to pass currentUser name, username, email, password
}

- (IBAction)followersTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC= [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [self.navigationController pushViewController:likersVC animated:YES];
    //write code here to pass user to likersVC and show followers
}


- (IBAction)followingTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC= [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [self.navigationController pushViewController:likersVC animated:YES];
    //write code here to pass user to likersVC and show followings
}

- (IBAction)editImageTapGesture:(UITapGestureRecognizer *)sender
{
    [self showCamera];
    //write code to show image picker
}


-(void)showCamera
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie];
    imagePicker.allowsEditing = NO;
    imagePicker.showsCameraControls = YES;
    
//    imagePicker.cameraOverlayView = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];

}

@end
