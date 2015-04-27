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
#import "FDFollow.h"
#import "Constants.h"

@implementation LikersTableViewCell

- (void)awakeFromNib {

    self.likersCellImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.likersCellImageView.layer.cornerRadius = 20;
    self.likersCellImageView.layer.borderWidth = 1.0;
    self.likersCellImageView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)onFollowButtonTap:(UIButton *)sender
{
//    [self.delegate shouldFollowOrUnfollowOnFollowButtonTap:self.indexPath];
//
//    if (![self.followButton.backgroundColor isEqual:kFoodiCornNavBarColor]) {
//        self.followButton.backgroundColor = kFoodiCornNavBarColor;
//
//
//        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.followButton setTitle:@"Following" forState:UIControlStateNormal];
//        //write code to show that current user followed another use
//        FDPFUser *cellUser = self.cellUser;
//
//
//        [FDFollow addFollow:cellUser];
//
////        NSLog(@"%lu", me.followings.count);
//
//    }else
//    { 
//
//        [self.followButton setTitleColor:kFoodiCornNavBarColor forState:UIControlStateNormal];
////        FDPFUser *cellUser = self.cellUser;
//        [self.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
//        self.followButton.backgroundColor = [UIColor whiteColor];
//        //write code to unfollow a user
////        [FDPFUser removeFollowingAndFollower:cell];
////        NSLog(@"%lu", me.followings.count);
//    }
//
//    //add code to add user at index to currentuser following array
}



- (IBAction)FollowButtonFromCell:(id)sender {

    NSLog(@"cell follow pressed");

    //add object / remove object locally.....
    //update Parse when view disappear
    //Just toggle locally
    if ([self.followButton.titleLabel.text isEqual:kFollow]) {

        self.followButton.backgroundColor = kFoodiCornNavBarColor;
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitle:kFollowing forState:UIControlStateNormal];

        //+1
        [self.addFDFollowArray addObject:self.cellUser];
        NSLog(@"%li", self.addFDFollowArray.count);

    }else{ //unfollow

        [self.followButton setTitleColor:kFoodiCornNavBarColor forState:UIControlStateNormal];
        [self.followButton setTitle:kFollow forState:UIControlStateNormal];
        self.followButton.backgroundColor = [UIColor whiteColor];

        //-1
        [self.removeFDFollowArray addObject:self.cellUser];
        NSLog(@"%li", self.removeFDFollowArray.count);

    }


}



@end
