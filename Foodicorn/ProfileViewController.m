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

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowingLabel;
@property NSArray *collectionArray;
@property NSDictionary *collectionDict;
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionDict = @{ @"cell": @"Cell A",
                              @"userImageName": @"person",
                              @"userName": @"tylorswift",
                              @"numOfFollowers": @"5",
                              @"numOfFollowing": @"1",
                              @"collections": @[@"food1", @"food2", @"food3", @"food4", @"food5", @"food7"]
                           };

     self.collectionArray = [self.collectionDict objectForKey:@"collections"];

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
    NSString *userImage = [self.collectionDict objectForKey:@"userImageName"];
    self.profileImageView.image =[UIImage imageNamed:userImage];
    self.profileUsernameLabel.text = [self.collectionDict objectForKey:@"userName"];
    self.profileFollowersLabel.text =[self.collectionDict objectForKey:@"numOfFollowers"];
    self.profileFollowingLabel.text =[self.collectionDict objectForKey:@"numOfFollowing"];



    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)onEditProfileButtonTap:(id)sender
{
    
}

@end
