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
    self.usernameLabel.textColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.usernameLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.likesLabel.userInteractionEnabled = YES;
    self.likesLabel.textColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.likesLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.mainFeedImageView.userInteractionEnabled = YES;
    self.mainFeedImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.mainFeedImageView.layer.borderWidth = 4.0f;
    self.mainFeedImageView.image = nil;

    self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.layer.borderWidth = 1.0;
    self.userImage.layer.masksToBounds = YES;
    self.userImage.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
