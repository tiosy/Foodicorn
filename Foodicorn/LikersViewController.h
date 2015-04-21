//
//  LikersViewController.h
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikersViewController : UIViewController
@property NSArray *usersArray;
@property (weak, nonatomic) IBOutlet UITableView *likersTableView;

@end
