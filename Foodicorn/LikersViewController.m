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
#import "FDPFUser.h"
#import "FDFollow.h"

@interface LikersViewController ()<UITableViewDataSource, UITableViewDelegate, LikersTableViewCellDelegate>
@end

@implementation LikersViewController

-(void)setUsersArray:(NSArray *)usersArray
{
    _usersArray = [usersArray mutableCopy];
    [self.likersTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code for likers of photo or followers of user or the people whom a user follows
    LikersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    cell.delegate = self;
    FDPFUser *theUser= [self.usersArray objectAtIndex:indexPath.row];

    PFFile *imageFile = theUser.profileThumbnailPFFile;
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

    [cell setCellUser:theUser];

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


-(void)shouldFollowOrUnfollowOnFollowButtonTap:(NSIndexPath *)indexPath
{
//        LikersTableViewCell *cell = [LikersTableViewCell new];
//        NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
//        NSData *imgData = [dict objectForKey:@"profileImage"];
//        UIImage *image = [UIImage imageWithData:imgData];
//        NSLog(@"%@", self.me.followings);

//    NSLog(@"%lu", self.me.followings.count);


}



@end
