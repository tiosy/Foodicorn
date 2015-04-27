//
//  LSViewController.m
//  Foodicorn
//
//  Created by tim on 4/18/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//


#import "LoginSignUpViewController.h"
#import "Constants.h"
#import <ParseUI/ParseUI.h>

#import "FDPFUser.h"
#import "FDUser.h"
#import "FDDish.h"
#import "FDLike.h"

@interface LoginSignUpViewController () <PFLogInViewControllerDelegate , PFSignUpViewControllerDelegate>

@property NSMutableArray *usersMutArray;
@property NSMutableArray *dishesMutArray;
@end



@implementation LoginSignUpViewController

-(void)viewWillAppear:(BOOL)animated{


}

- (void)viewDidLoad {
   [super viewDidLoad];

////
//    self.usersMutArray = [NSMutableArray new];
//    self.dishesMutArray = [NSMutableArray new];
////
//

    //TESTING adding following

//    FDPFUser *me = [FDPFUser currentUser];
//    NSLog(@"username %@", me.username);
//

    

//==============================================

//    // suppose we have a user we want to follow
//    PFUser *otherUser = ...
//
//    // create an entry in the Follow table
//    PFObject *follow = [PFObject objectWithClassName:@"Follow"];
//    [follow setObject:[PFUser currentUser]  forKey:@"from"];
//    [follow setObject:otherUser forKey:@"to"];
//    [follow setObject:[NSDate date] forKey@"date"];
//    [follow saveInBackground];
//
//
//    // set up the query on the Follow table
//    PFQuery *query = [PFQuery queryWithClassName:@"Follow"];
//    [query whereKey:@"from" equalTo:[PFUser currentUser]];
//
//    // execute the query
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        for(PFObject *o in objects) {
//            // o is an entry in the Follow table
//            // to get the user, we get the object with the to key
//            PFUser *otherUser = [o objectForKey@"to"];
//
//            // to get the time when we followed this user, get the date key
//            PFObject *when = [o objectForKey@"date"];
//        }
//    }];
//
//    // set up the query on the Follow table
//    PFQuery *query = [PFQuery queryWithClassName:@"Follow"];
//    [query whereKey:@"to" equalTo:[PFUser currentUser]];
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        for(PFObject *o in objects) {
//            // o is an entry in the Follow table
//            // to get the user, we get the object with the from key
//            PFUser *otherUser = [o objectForKey@"from"];
//
//            // to get the time the user was followed, get the date key
//            PFObject *when = [o objectForKey@"date"];
//        }
//    }];

//==============================================


//
//    UIImage *imageUIImage;
//    NSString *rId;
//
//    imageUIImage= [UIImage imageNamed:@"food1"];
//    rId = @"111";
//    [FDDish addDish:imageUIImage recipeId:rId];
//    [FDLike addLike:rId image:imageUIImage];
//
//    imageUIImage= [UIImage imageNamed:@"food2"];
//    rId = @"222";
//    [FDDish addDish:imageUIImage recipeId:rId];
//    [FDLike addLike:rId image:imageUIImage];
//    imageUIImage= [UIImage imageNamed:@"food3"];
//    rId = @"333";
//    [FDDish addDish:imageUIImage recipeId:rId];
//    [FDLike addLike:rId image:imageUIImage];
//
//    imageUIImage= [UIImage imageNamed:@"food4"];
//    rId = @"444";
//    [FDDish addDish:imageUIImage recipeId:rId];
//    [FDLike addLike:rId image:imageUIImage];


//
//
//    [FDLike likedByUsersWithCompletion:@"111" completionHandler:^(NSArray *array) {
//        self.usersMutArray = [array mutableCopy];
//
//        NSLog(@"-user-------%ld--", self.usersMutArray.count);
//
//    }];

//    [FDLike likeDishesWithCompletion:^(NSArray *array) {
//        self.dishesMutArray = [array mutableCopy];
//         NSLog(@"-dish-------%ld-", self.dishesMutArray.count);
//
//    }];
//    




//    //==============================================
////
////        // suppose we are in Dish detail and we want to follow [FDPFUser currentUser]
////    
//
//
////        // set up the query on the Like table
//        PFQuery *query = [PFQuery queryWithClassName:@"Like"];
//        [query whereKey:@"from" equalTo:receipeId];
//    
//        // execute the query
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            for(PFObject *o in objects) {
//                // o is an entry in the Like table
//                // to get the user, we get the object with the to key
//                PFUser *otherUser = [o objectForKey@"to"];
//    
//                // to get the time when we followed this user, get the date key
//                PFObject *when = [o objectForKey@"date"];
//            }
//        }];
////
//        // set up the query on the Follow table
//        PFQuery *query = [PFQuery queryWithClassName:@"Follow"];
//        [query whereKey:@"to" equalTo:[PFUser currentUser]];
//    
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            for(PFObject *o in objects) {
//                // o is an entry in the Follow table
//                // to get the user, we get the object with the from key
//                PFUser *otherUser = [o objectForKey@"from"];
//    
//                // to get the time the user was followed, get the date key
//                PFObject *when = [o objectForKey@"date"];
//            }
//        }];
//    
//    //==============================================











}

//////////////////////////////////////////////////////////////

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    FDPFUser *me = [FDPFUser currentUser];
    if(me){
        //logged-in already, pass login view and display mainfeed
        UITabBarController *rootTabBarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootTabBarController"];
        [rootTabBarVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:rootTabBarVC animated:YES completion:nil];

    }
    else { // has not loggin yet, display login view
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

        //Custom the Logo

        self.view.backgroundColor = kFoodiCornNavBarColor;
        logInViewController.logInView.backgroundColor = kFoodiCornNavBarColor;
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food2"]];
        logoView.contentMode=UIViewContentModeScaleAspectFill;
        logInViewController.logInView.logo = logoView; // logo can be any UIView

        // Customize the Sign Up View Controller
        signUpViewController.signUpView.backgroundColor = kFoodiCornNavBarColor;
        UIImageView *logoView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food2"]];
        logoView2.contentMode=UIViewContentModeScaleAspectFill;
        signUpViewController.signUpView.logo=logoView2;
        logInViewController.signUpController = signUpViewController;

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

   [self dismissViewControllerAnimated:YES completion:^{
        //[self performSegueWithIdentifier:@"SegueToRoot" sender:self];
       //logged-in sucessfully, display RootTabBar VC
       UITabBarController *rootTabBarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootTabBarController"];
       [rootTabBarVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
       [self presentViewController:rootTabBarVC animated:YES completion:nil];
   }];
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

    //create default profile image
    FDPFUser *me = [FDPFUser currentUser];
    UIImage *img = [UIImage imageNamed:@"person"];
    NSData *imageNSData = UIImagePNGRepresentation(img);
    PFFile *imagePFFile = [PFFile fileWithName:me.objectId data:imageNSData]; //use uniqe objectId as file name
    [imagePFFile saveInBackground];
    me.profileThumbnailPFFile = imagePFFile;
    [me saveInBackground];

    // Dismiss the PFSignUpViewController
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];

    [FDPFUser logOut];
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    LoginSignUpViewController *loginVC= [storyboard instantiateViewControllerWithIdentifier:@"LoginSignUpVC"];
    //    [self.navigationController presentViewController:loginVC animated:YES completion:nil];


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


