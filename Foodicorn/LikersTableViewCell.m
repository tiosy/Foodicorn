//
//  LikersTableViewCell.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/20/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "LikersTableViewCell.h"
#import "LikersViewController.h"
#import "FDPFUser.h"

@implementation LikersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)onFollowButtonTap:(UIButton *)sender
{
//    LikersTableViewCell *likersCell = [LikersTableViewCell new];
//    NSIndexPath *indexPath = [self.likersTableView indexPathForSelectedRow];
//    NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
//    NSData *imgData = [dict objectForKey:@"profileImage"];
//    UIImage *image = [UIImage imageWithData:imgData];

    if (![self.followButton.backgroundColor isEqual:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2]]) {
        self.followButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitle:@"Following" forState:UIControlStateNormal];
        //write code to show that current user followed another user

//        [FDPFUser addFollowingAndFollower:image username:[dict objectForKey:@"username"] fullname:[dict objectForKey:@"fullname"] followingNSString:[dict objectForKey:@"follow"]];

    }else
    {
        [self.followButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        [self.followButton setTitle:@"Follow" forState:UIControlStateNormal];
        self.followButton.backgroundColor = [UIColor whiteColor];
        //write code to unfollow a user
    }

    //add code to add user at index to currentuser following array
}




@end