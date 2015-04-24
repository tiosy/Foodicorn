//
//  WebViewController.h
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yummly.h"

@interface WebViewController : UIViewController

@property Yummly *yummly;
@property NSString *name;
@property NSString *webUrl;
@property NSString *imageUrl;


@end
