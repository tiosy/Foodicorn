//
//  FavView.h
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavView : UIView

- (void)setCollectionData:(NSArray *)collectionData;

@property (nonatomic) UIViewController *parentVC;

@end
