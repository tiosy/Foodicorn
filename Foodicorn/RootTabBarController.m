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

    mainNavVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    mainNavVC.tabBarItem.title = @"Home";

    searchNavVC.tabBarItem.image = [UIImage imageNamed:@"search"];
    searchNavVC.tabBarItem.title = @"Search";

    favoriteNavVC.tabBarItem.image = [UIImage imageNamed:@"like"];
    favoriteNavVC.tabBarItem.title = @"Likes";

    profileNavVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    profileNavVC.tabBarItem.title = @"Profile";

}



@end
