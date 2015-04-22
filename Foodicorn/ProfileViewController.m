//
//  ProfileViewController.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/15/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "DetailViewController.h"
#import "LikersViewController.h"
#import "EditProfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "FDPFUser.h"
#import "FDUtility.h"
#import "FDTransaction.h"
#import "FDDish.h"
#import "FDLike.h"

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingsLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followersTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *followingTapGesture;
@property (nonatomic)  NSArray *collectionArray;
@property NSDictionary *collectionDict;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //will change title to user.username

    FDPFUser *currentUser = [FDPFUser currentUser];
    self.title = currentUser.username;

    self.userNameLabel.text = currentUser.fullName;

    self.followersTapGesture = [UITapGestureRecognizer new];
    self.followersTapGesture.delegate = self;
    self.followersTapGesture.enabled = YES;
    self.followersLabel.userInteractionEnabled = YES;
    self.followersLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.followersLabel.layer.borderWidth = 1.0;
    self.followersLabel.layer.cornerRadius = 10;
    self.followersLabel.clipsToBounds = YES;

    self.followingTapGesture = [UITapGestureRecognizer new];
    self.followingTapGesture.delegate = self;
    self.followingTapGesture.enabled = YES;
    self.followingsLabel.userInteractionEnabled = YES;
    self.followingsLabel.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.followingsLabel.layer.borderWidth = 1.0;
    self.followingsLabel.layer.cornerRadius = 10;
    self.followingsLabel.clipsToBounds = YES;

    self.imageViewTapGesture = [UITapGestureRecognizer new];
    self.imageViewTapGesture.delegate = self;
    self.imageViewTapGesture.enabled = YES;
    self.profileImageView.userInteractionEnabled = YES;
    self.profileImageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    self.profileImageView.layer.borderWidth = 1.0f;
    self.profileImageView.layer.cornerRadius = 39.0;
    self.profileImageView.layer.masksToBounds = YES;

    PFFile *userImageFile = currentUser.profileThumbnailPFFile;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         if (!error) {
             UIImage *image = [UIImage imageWithData:imageData];
             self.profileImageView.image = image;
         }

     }];

    [FDLike likeDishesWithCompletion:^(NSArray *array) {
        self.collectionArray = array;
    }];

//    PFQuery *query = [FDLike query];
//    [query whereKey:@"to" equalTo:currentUser.objectId];
//    [query orderByDescending:@"createdAt"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error)
//        {
//            self.collectionArray = objects;
//        } else
//        {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];

}

-(void)setCollectionArray:(NSArray *)collectionArray
{
    _collectionArray = collectionArray;
    [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    FDLike *like = [self.collectionArray objectAtIndex:indexPath.row];

    PFFile *dishImageFile = like.imagePFfile;
    [dishImageFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error)
    {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.profileCellImage.image = img;
        }
    }];

    //NEED TO CHANGE EVERYTHING FROM TRANSACTION TO LIKE

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];

//    CGPoint location = [sender locationInView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

    FDTransaction *transaction = [self.collectionArray objectAtIndex:indexPath.row];
    detailVC.recipeID = transaction.dishID;
    //NEED TO CHANGE FROM TRANSACTION TO LIKE
    //write code here to pass yummly recipe to detail
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditProfileViewController *editVC = segue.destinationViewController;
    editVC.user = [FDPFUser currentUser];
    //write code in here to pass currentUser name, username, email, password
}

- (IBAction)followersTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC= [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [self.navigationController pushViewController:likersVC animated:YES];
    //write code here to pass user to likersVC and show followers
}


- (IBAction)followingTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC= [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [self.navigationController pushViewController:likersVC animated:YES];
    //write code here to pass user to likersVC and show followings
}

- (IBAction)editImageTapGesture:(UITapGestureRecognizer *)sender
{
    [self showAlert];
}

#pragma mark - IMAGEPICKER CONTROLS

-(void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [self showCamera];
                              }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Choose From Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [self showLibrary];
    }];

    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];

    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showCamera
{

    UIImagePickerController *imagePicker = [UIImagePickerController new];

    if (UIImagePickerControllerSourceTypeCamera)
    {
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie];
        imagePicker.allowsEditing = NO;
        imagePicker.showsCameraControls = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


-(void)showLibrary
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];

    if (!UIImagePickerControllerSourceTypePhotoLibrary)
    {
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *profImage = [FDUtility imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        NSData *imageData = UIImagePNGRepresentation(profImage);

        FDPFUser *currentUser = [FDPFUser currentUser];
        PFFile *imageFile = [PFFile fileWithName:currentUser.objectId data:imageData];
        [imageFile saveInBackground];

        currentUser.profileThumbnailPFFile = imageFile;
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
            if (error)
             {
                 NSLog(@"This is the %@", error);
             }
         }];

        [self.profileImageView setImage:[UIImage imageWithData:imageData]];

    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaType);
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image/video"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
