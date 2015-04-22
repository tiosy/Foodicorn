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

@interface EditProfileViewController () <UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editEmailTextField;
@property (weak, nonatomic) IBOutlet UIButton *logOffButton;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Profile";
    self.editNameTextField.placeholder = @"Edit Name";
    self.editUserNameTextField.placeholder = @"Edit User Name";
    self.editEmailTextField.placeholder = @"Edit Email";

    self.logOffButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2];
    self.logOffButton.tintColor = [UIColor whiteColor];

    self.editNameTextField.text = self.user.fullName;
    self.editUserNameTextField.text = self.user.username;
    self.editEmailTextField.text = self.user.email;
//    [self.editPasswordTextField setSecureTextEntry:YES];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    FDPFUser *currentUser = [FDPFUser currentUser];
    currentUser.fullName = self.editNameTextField.text;
    currentUser.username = self.editUserNameTextField.text;
    currentUser.email = self.editEmailTextField.text;
//    currentUser.password = self.editPasswordTextField.text;
    [self.editNameTextField resignFirstResponder];
    [self.editUserNameTextField resignFirstResponder];
    [self.editEmailTextField resignFirstResponder];
    [currentUser saveInBackground];

    return YES;
}

- (IBAction)logOffButtonTapped:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log Off" message:@"Are you sure you want to log off" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *logOffAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [FDPFUser logOut];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginSignUpViewController *loginVC= [storyboard instantiateViewControllerWithIdentifier:@"LoginSignUpVC"];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:logOffAction];
    [self presentViewController:alertController animated:YES completion:nil];
    //write code in here to segue back to login page
}


@end
