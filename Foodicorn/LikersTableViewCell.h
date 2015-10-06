//
//  LikersTableViewCell.h
//  Foodicorn
//
//  Created by Jazz Santiago on 4/20/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDPFUser.h"


@protocol LikersTableViewCellDelegate <NSObject>


//-(void)shouldFollowOrUnfollowOnFollowButtonTap: (NSIndexPath *)indexPath;

@end

@interface LikersTableViewCell : UITableViewCell
@property id<LikersTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *likersCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *likersUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likersSubtitleLabel;
@property (strong, nonatomic) FDPFUser *cellUser;
@property NSIndexPath *indexPath;
@property NSMutableArray *addFDFollowArray;
@property NSMutableArray *removeFDFollowArray;
@property NSArray *userData;
@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end
