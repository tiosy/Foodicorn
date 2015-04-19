//
//  EditProfileViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "EditProfileViewController.h"
#import "FDPFUser.h"
#import "LoginSignUpViewController.h"

@interface EditProfileViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *editPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logOffButton;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Profile";
    self.editNameTextField.placeholder = @"Edit Name";
    self.editUserNameTextField.placeholder = @"Edit User Name";
    self.editEmailTextField.placeholder = @"Edit Email";
    self.editPasswordTextField.placeholder = @"Edit Password";

    self.logOffButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.logOffButton.tintColor = [UIColor whiteColor];
}

- (IBAction)logOffButtonTapped:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log Off" message:@"Are you sure you want to log off" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *logOffAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [FDPFUser logOut];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginSignUp" bundle:nil];
        LoginSignUpViewController *loginVC= [storyboard instantiateViewControllerWithIdentifier:@"LoginSignUp"];
        [self.navigationController popToViewController:loginVC animated:YES];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:logOffAction];
    [self presentViewController:alertController animated:YES completion:nil];
    //write code in here to segue back to login page
}


@end
