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
    self.likesLabel.userInteractionEnabled = YES;
    self.mainFeedImageView.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
