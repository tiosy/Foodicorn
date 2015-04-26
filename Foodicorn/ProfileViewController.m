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

#import "Constants.h"
#import "FDUtility.h"

#import "FDPFUser.h"
#import "FDFollow.h"
#import "FDLike.h"

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *followersCount;
@property (weak, nonatomic) IBOutlet UIButton *followingsCount;

//user profile image
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;

//collection view
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic)  NSArray *collectionArray;

@property (nonatomic) NSMutableArray *followingsArray;
@property (nonatomic) NSMutableArray *followersArray;

@end

@implementation ProfileViewController

-(void)viewDidAppear:(BOOL)animated
{

    [self calculateNumFollowers];
    [self calculateNumFollowings];

    [FDLike likeDishesWithCompletion:^(NSArray *array) {
        self.collectionArray = [array mutableCopy];
    }];
}


//setter collection array
-(void)setCollectionArray:(NSArray *)collectionArray
{
    _collectionArray = collectionArray;
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //load my favorite dishes
    [FDLike likeDishesWithCompletion:^(NSArray *array) {
        self.collectionArray = array;
    }];

    FDPFUser *currentUser = [FDPFUser currentUser];
    self.title = currentUser.username;

    self.userNameLabel.text = currentUser.fullName;



    self.imageViewTapGesture = [UITapGestureRecognizer new];
    self.imageViewTapGesture.delegate = self;
    self.imageViewTapGesture.enabled = YES;
    self.profileImageView.userInteractionEnabled = YES;
    self.profileImageView.layer.borderColor = kFoodiCornNavBarColor.CGColor;
    self.profileImageView.layer.borderWidth = 1.0f;
    self.profileImageView.layer.cornerRadius = 39.0;
    self.profileImageView.layer.masksToBounds = YES;

    self.collectionView.alwaysBounceVertical = YES;

    //PFFile *userImageFile = currentUser.profileThumbnailPFFile;
    PFFile *userImageFile =[currentUser objectForKey:@"profileThumbnailPFFile"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
     {
         if (!error) {
             UIImage *image = [UIImage imageWithData:imageData];
             self.profileImageView.image = image;
         }

     }];
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

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

    PFFile *dishImageFile = [like objectForKey:@"imagePFFile"];
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

    FDLike *like = [self.collectionArray objectAtIndex:indexPath.row];
    detailVC.recipeID = like.from;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditProfileViewController *editVC = segue.destinationViewController;
    editVC.user = [FDPFUser currentUser];
    //write code in here to pass currentUser name, username, email, password
}

- (IBAction)followersButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC= [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    [self.navigationController pushViewController:likersVC animated:YES];
    //write code here to pass user to likersVC and show followers

}

- (IBAction)followingButton:(id)sender {

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



#pragma mark - helper methods

//calulate my followers
-(void) calculateNumFollowers{

    FDPFUser *me = [FDPFUser currentUser];
    //# of followers
    [FDFollow followersWithCompletion:me completionHandler:^(NSArray *array) {
        self.followersArray = [array mutableCopy];

        NSString *count = [NSString stringWithFormat:@"%ld", (unsigned long)self.followersArray.count];

        self.followersCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followersCount.titleLabel.numberOfLines=0;
        self.followersCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followersCount setTitle:[NSString stringWithFormat:@"%@\nfollowers",count] forState:UIControlStateNormal];

    }];
}

-(void) calculateNumFollowings{

    FDPFUser *me = [FDPFUser currentUser];

    //# of followings
    [FDFollow followingsWithCompletion:me completionHandler:^(NSArray *array) {
        self.followingsArray = [array mutableCopy];

        NSString *count = [NSString stringWithFormat:@"%ld", (unsigned long)self.followingsArray.count];

        self.followingsCount.titleLabel.textColor=kFoodiCornNavBarColor;
        self.followingsCount.titleLabel.numberOfLines=0;
        self.followingsCount.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.followingsCount setTitle:[NSString stringWithFormat:@"%@\nfollowing",count] forState:UIControlStateNormal];
    }];
    
}









@end
