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

    self.userImage.layer.cornerRadius = 10;
    self.userImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
