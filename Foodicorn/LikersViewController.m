//
//  LikersViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "LikersViewController.h"
#import "LikersTableViewCell.h"

#import "ProfileViewController.h"
#import "UserProfileViewController.h"

#import "Constants.h"   

#import "FDPFUser.h"
#import "FDFollow.h"




@interface LikersViewController ()<UITableViewDataSource, UITableViewDelegate, LikersTableViewCellDelegate>

@property NSMutableArray *addFDFollowArray;
@property NSMutableArray *removeFDFollowArray;
@property (nonatomic) NSArray *followingsArray;

@end

@implementation LikersViewController

-(void)viewDidDisappear:(BOOL)animated
{
    for (FDPFUser *user in self.addFDFollowArray)
    {
        [FDFollow addFollow:user];
    }

    for (FDPFUser *user in self.removeFDFollowArray) {
        [FDFollow removeFollowingWithCompletion:user completionHandler:^{

        }];
    }


}

-(void)viewDidAppear:(BOOL)animated
{

    //followings
    FDPFUser *me = [FDPFUser currentUser];
    [FDFollow followingsWithCompletion:me completionHandler:^(NSArray *array) {
        self.followingsArray = array;
    }];

    
}


-(void)setFollowingsArray:(NSArray *)followingsArray{
    _followingsArray = followingsArray;
    [self.likersTableView reloadData];
}

-(void)setUsersArray:(NSArray *)usersArray
{
    _usersArray = [usersArray mutableCopy];
    [self.likersTableView reloadData];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.removeFDFollowArray = [NSMutableArray new];
    self.addFDFollowArray = [NSMutableArray new];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code for likers of photo or followers of user or the people whom a user follows
    LikersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    cell.delegate = self;
    FDPFUser *theUser= [self.usersArray objectAtIndex:indexPath.row];

    //PFFile *imageFile = theUser.profileThumbnailPFFile; // crashing sometimes...not sure why...use objectForKey instead
    PFFile *imageFile = [theUser objectForKey:@"profileThumbnailPFFile"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         if (!error) {
             UIImage *image = [UIImage imageWithData:imageData];
             cell.likersCellImageView.image = image;
         }
     }];

    cell.likersUsernameLabel.text = theUser.username;
    cell.likersSubtitleLabel.text = theUser.fullName;
    cell.indexPath = indexPath;

    //if following...change Button title and color
    if([self.followingsArray containsObject:theUser]){

        cell.followButton.backgroundColor = kFoodiCornNavBarColor;
        [cell.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.followButton setTitle:kFollowing2 forState:UIControlStateNormal];
        
    }
    cell.addFDFollowArray = self.addFDFollowArray;
    cell.removeFDFollowArray = self.removeFDFollowArray;
    cell.cellUser = theUser;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDPFUser *currentUser = [FDPFUser currentUser];
    FDPFUser *user = self.usersArray[indexPath.row];
    if ([user.username isEqualToString:currentUser.username])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
        ProfileViewController *profileVC= [storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        [self.navigationController pushViewController:profileVC animated:YES];

    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
        UserProfileViewController *userVC= [storyboard instantiateViewControllerWithIdentifier:@"UserVC"];
        [self.navigationController pushViewController:userVC animated:YES];
        userVC.user = user;
    }
}




@end
