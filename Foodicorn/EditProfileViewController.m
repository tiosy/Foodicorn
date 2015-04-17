//
//  EditProfileViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *editPasswordTextField;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Profile";
    self.editNameTextField.placeholder = @"Edit Name";
    self.editUserNameTextField.placeholder = @"Edit User Name";
    self.editEmailTextField.placeholder = @"Edit Email";
    self.editPasswordTextField.placeholder = @"Edit Password";
}



@end
