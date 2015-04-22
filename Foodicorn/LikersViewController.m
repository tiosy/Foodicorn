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

-(void)setUsersArray:(NSArray *)usersArray
{
    _usersArray = usersArray;
    NSLog(@"%@", usersArray);
    [self.likersTableView reloadData];
}

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
    FDPFUser *cellUser = [self.usersArray objectAtIndex:indexPath.row];
    NSData *imgData = cellUser.profileThumbnailNSData;
    NSString *username = cellUser.username;
    UIImage *image = [UIImage imageWithData:imgData];
//    NSLog(@"%@", username);
    cell.likersCellImageView.image = image;
    cell.likersUsernameLabel.text = username;
    NSString *userFullName = cellUser.fullName;
    cell.likersSubtitleLabel.text = userFullName;
    cell.indexPath = indexPath;

    [cell setCellUser:cellUser];


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
