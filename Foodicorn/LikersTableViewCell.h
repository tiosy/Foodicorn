//
//  LikersTableViewCell.h
//  Foodicorn
//
//  Created by Jazz Santiago on 4/20/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *likersCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *likersUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likersSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@property NSArray *userData;

@end
