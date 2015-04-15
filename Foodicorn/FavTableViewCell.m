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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCollectionData:(NSArray *)collectionData {

    [self.favCellView setCollectionData:collectionData];
}

@end
