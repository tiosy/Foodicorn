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


@interface LikersViewController ()<UITableViewDataSource, UITableViewDelegate, LikersTableViewCellDelegate>
@property FDPFUser *me;
@end

@implementation LikersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.me = [FDPFUser currentUser];

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
    cell.delegate = self;
    NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
    NSData *imgData = [dict objectForKey:@"profileImage"];
    NSString *username = [dict objectForKey:@"username"];
    UIImage *image = [UIImage imageWithData:imgData];
    cell.likersCellImageView.image = image;
    cell.likersUsernameLabel.text = username;
    NSString *userFullName = [dict objectForKey:@"fullname"];
    cell.likersSubtitleLabel.text = userFullName;
    if ([[dict objectForKey:@"followingNSString"] isEqualToString:@"+ Follow"])
    {
        [cell.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
    }else
    {
        [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
    }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)shouldFollowOrUnfollowOnFollowButtonTap:(UIButton *)button
{
        LikersTableViewCell *cell = [LikersTableViewCell new];
        NSIndexPath *indexPath = [NSIndexPath ind]
        NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
        NSData *imgData = [dict objectForKey:@"profileImage"];
        UIImage *image = [UIImage imageWithData:imgData];


        [FDPFUser addFollowingAndFollower:image username:[dict objectForKey:@"username"] fullname:[dict objectForKey:@"fullname"] followingNSString:[dict objectForKey:@"followingNSString"]];
        [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
// NSLog(@"%@", button.titleLabel.text);
//    if ([cell.followButton.titleLabel.text  isEqual: @"+ Follow"])
//    {
//        [FDPFUser addFollowingAndFollower:image username:[dict objectForKey:@"username"] fullname:[dict objectForKey:@"fullname"] followingNSString:[dict objectForKey:@"followingNSString"]];
//        [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
//
//    }else
//    {
//        [FDPFUser removeFollowingAndFollower:[dict objectForKey:@"username"]];
//        [cell.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
//    }

//    NSLog(@"%lu", self.me.followings.count);


}



@end
