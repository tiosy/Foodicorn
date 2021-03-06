//
//  AppDelegate.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import "FDPFUser.h"
#import "FDDish.h"
#import "FDTransaction.h"
#import "FDLike.h"
#import "FDFollow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //[Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];



    //When created Subclass of PFObjects...put a load here
    //[...registerSubclass]
    [FDPFUser load];
    [FDDish load];
    [FDTransaction load];
    [FDLike load];
    [FDFollow load];


    // Initialize Parse.
    [Parse setApplicationId:@"cvUotZUxRQ2x3IBqzH5B0WtSlGhxPMqoO1mXMKnW"
                  clientKey:@"riwIEjDVAJPXerKgs9d8wFFlIyxBCYoOub5ZGacH"];

    //revocable token
    [FDPFUser enableRevocableSessionInBackground];

    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:kFoodiCornNavBarColor];
    //[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:kFoodiCornNavBarColor];
    [[UIButton appearance] setTintColor:kFoodiCornNavBarColor];

    [[UISegmentedControl appearance] setTintColor:kFoodiCornNavBarColor];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kFoodiCornNavBarColor} forState:UIControlStateNormal];



    //from tim
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Myriad" size:17.0], NSFontAttributeName, nil]];





    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
