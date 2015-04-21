//
//  LikersViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "LikersViewController.h"
#import "LikersTableViewCell.h"
#import "FDPFUser.h"


@interface LikersViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LikersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.usersArray);

//    self.usersArray = @[ @{@"userImageName" : @"person",
//                           @"userName" : @"Taylor S.",
//                           @"userFullName" : @"Taylor Swift",
//                           @"following" : @"YES"
//                           },
//                         @{@"userImageName" : @"person2",
//                           @"userName" : @"Lady G",
//                           @"userFullName" : @"Lady Gaga",
//                           @"following" : @"YES"
//                           },
//                         @{@"userImageName" : @"person3",
//                           @"userName" : @"Hannah Montana",
//                           @"userFullName" : @"Miley Cyrus",
//                           @"following" : @"NO"
//                           }
//                        ];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code for likers of photo or followers of user or the people whom a user follows
    LikersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
    NSData *imgData = [dict objectForKey:@"profileImage"];
    UIImage *image = [UIImage imageWithData:imgData];
    cell.likersCellImageView.image = image;
    cell.likersUsernameLabel.text = [dict objectForKey:@"username"];
    NSString *userFullName = [dict objectForKey:@"fullname"];
    cell.likersSubtitleLabel.text = userFullName;



    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (IBAction)onFollowButtonTap:(UIButton *)sender
{
    LikersTableViewCell *cell = [self.likersTableView dequeueReusableCellWithIdentifier:@"UsersListCell"];
    NSIndexPath *indexPath = [self.likersTableView indexPathForSelectedRow];
    NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
    NSData *imgData = [dict objectForKey:@"profileImage"];
    UIImage *image = [UIImage imageWithData:imgData];
    
    if (![cell.followButton.backgroundColor isEqual:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2]]) {
        cell.followButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
        [cell.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
        //write code to show that current user followed another user
        [FDPFUser addFollowingAndFollower:image username:[dict objectForKey:@"username"] fullname:[dict objectForKey:@"fullname"] followingNSString:[dict objectForKey:@"follow"]];
        [self.likersTableView reloadData];

    }else
    {
        [cell.followButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        [cell.followButton setTitle:@"Follow" forState:UIControlStateNormal];
        cell.followButton.backgroundColor = [UIColor whiteColor];
        [self.likersTableView reloadData];
        //write code to unfollow a user
    }

    //add code to add user at index to currentuser following array
}



@end
