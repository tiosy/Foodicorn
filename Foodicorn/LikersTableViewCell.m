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
    [self.delegate shouldFollowOrUnfollowOnFollowButtonTap:self.indexPath];

    if (![self.followButton.backgroundColor isEqual:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2]]) {
        self.followButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];

        FDPFUser *me = [FDPFUser currentUser];
        
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitle:@"Following" forState:UIControlStateNormal];
        //write code to show that current user followed another use
        NSDictionary *dict = self.dictData;
        NSData *imgData = [dict objectForKey:@"profileImage"];
        UIImage *image = [UIImage imageWithData:imgData];
        [FDPFUser addFollowingAndFollower:image username:[dict objectForKey:@"username"] fullname:[dict objectForKey:@"fullname"] followingNSString:[dict objectForKey:@"followingNSString"]];
        NSLog(@"%lu", me.followings.count);

    }else
    {   FDPFUser *me = [FDPFUser currentUser];

        [self.followButton setTitleColor:[UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2] forState:UIControlStateNormal];
        NSDictionary *dict = self.dictData;
        [self.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
        self.followButton.backgroundColor = [UIColor whiteColor];
        //write code to unfollow a user
        [FDPFUser removeFollowingAndFollower:[dict objectForKey:@"username"]];
        NSLog(@"%lu", me.followings.count);
    }

    //add code to add user at index to currentuser following array
}

-(void) setDictData:(NSDictionary *)dictData
{
    _dictData = dictData;
    NSLog(@"%@", _dictData);
}





@end
