//
//  MainFeedTableViewCell.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "MainFeedTableViewCell.h"
#import "Constants.h"

@implementation MainFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.usernameLabel.userInteractionEnabled = YES;
    self.usernameLabel.textColor = kFoodiCornNavBarColor;
    self.usernameLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.likesLabel.userInteractionEnabled = YES;
    self.likesLabel.textColor = kFoodiCornNavBarColor;
    self.likesLabel.layer.borderColor = [UIColor whiteColor].CGColor;

    self.mainFeedImageView.userInteractionEnabled = YES;
    self.mainFeedImageView.layer.borderColor = kFoodiCornNavBarColor.CGColor;
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
