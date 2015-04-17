//
//  FavTableViewCell.h
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *favUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *favUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *favTimeLabel;
@property (nonatomic) UIViewController *parentVC;

- (void)setCollectionData:(NSArray *)collectionData;




@end
