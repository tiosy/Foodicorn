//
//  RootTabBarController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UIStoryboard *favoriteStoryboard = [UIStoryboard storyboardWithName:@"Favorite" bundle:nil];
    UIStoryboard *profileStoryboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];

    UINavigationController *mainNavVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainfeedNavVC"];
    UINavigationController *searchNavVC = [searchStoryboard instantiateViewControllerWithIdentifier:@"SearchNavVC"];
    UINavigationController *favoriteNavVC = [favoriteStoryboard instantiateViewControllerWithIdentifier:@"FavoriteNavVC"];
    UINavigationController *profileNavVC = [profileStoryboard instantiateViewControllerWithIdentifier:@"ProfileNavVC"];

    [self setViewControllers:@[mainNavVC, searchNavVC, favoriteNavVC, profileNavVC]];

}



@end
