//
//  MainFeedTableViewCell.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "MainFeedTableViewCell.h"

@implementation MainFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.usernameLabel.userInteractionEnabled = YES;
    self.usernameLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.usernameLabel.layer.borderWidth = 1.0f;
    self.usernameLabel.layer.cornerRadius = 10;
    self.usernameLabel.clipsToBounds = YES;

    self.likesLabel.userInteractionEnabled = YES;
    self.likesLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.likesLabel.layer.borderWidth = 1.0f;
    self.likesLabel.layer.cornerRadius = 10;
    self.likesLabel.clipsToBounds = YES;

    self.mainFeedImageView.userInteractionEnabled = YES;
    self.mainFeedImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.mainFeedImageView.layer.borderWidth = 2.0f;

    self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.layer.borderWidth = 1.0;
    self.userImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
