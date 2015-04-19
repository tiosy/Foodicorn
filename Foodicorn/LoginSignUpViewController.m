//
//  LSViewController.m
//  Foodicorn
//
//  Created by tim on 4/18/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import "LoginSignUpViewController.h"
#import <ParseUI/ParseUI.h>

#import "FDPFUser.h"

@interface LoginSignUpViewController () <PFLogInViewControllerDelegate , PFSignUpViewControllerDelegate>


@end

@implementation LoginSignUpViewController

- (void)viewDidLoad {
   [super viewDidLoad];


    //test ONLY.... remove after test
    //[FDPFUser logOut];


}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    FDPFUser *me = [FDPFUser currentUser];
    if(me){
        //logged-in already

        UITabBarController *rootTabBarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootTabBarController"];

        [rootTabBarVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:rootTabBarVC animated:YES completion:nil];

    }
    else { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate

        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate

        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];


        logInViewController.fields = (PFLogInFieldsUsernameAndPassword
                                      | PFLogInFieldsLogInButton
                                      | PFLogInFieldsSignUpButton
                                      | PFLogInFieldsPasswordForgotten
                                      | PFLogInFieldsDismissButton
                                      //   | PFLogInFieldsFacebook
                                      //   | PFLogInFieldsTwitter
                                      );

        self.view.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
        logInViewController.logInView.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food2"]];
        logInViewController.logInView.logo = logoView; // logo can be any UIView
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }


}

#pragma mark - PFLogInViewControllerDelegate (4 optionals)
// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }

    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    [self dismissViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"SegueToRoot" sender:self];


}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate (4 optionals)
// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;

    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }

    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }

    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    // Dismiss the PFSignUpViewController
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

@end


