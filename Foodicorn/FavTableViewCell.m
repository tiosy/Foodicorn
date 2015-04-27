//
//  FavTableViewCell.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FavTableViewCell.h"
#import "FavView.h"

@interface FavTableViewCell ()

@property (weak, nonatomic) IBOutlet FavView *favCellView;

@end
@implementation FavTableViewCell
- (void)awakeFromNib {

    self.favUserImageView.image = nil;
    self.favUserImageView.layer.borderWidth = 1.0f;
    self.favUserImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.favUserImageView.layer.cornerRadius = 20;
    self.favUserImageView.layer.masksToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCollectionData:(NSArray *)collectionData {

    [self.favCellView setCollectionData:collectionData];
}

-(void)setParentVC:(UIViewController *)parentVC
{
    [self.favCellView setParentVC:parentVC];
}

@end
