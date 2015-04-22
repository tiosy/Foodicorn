//
//  MainFeedViewController.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "MainFeedViewController.h"
#import "MainFeedTableViewCell.h"
#import "DetailViewController.h"
#import "LikersViewController.h"
#import "UserProfileViewController.h"
#import "ProfileViewController.h"
#import "Yummly.h"
#import "FDDish.h"
#import "FDLike.h"
#import "FDPFUser.h"
#import <parse/PFObject+Subclass.h>
#import "FDTransaction.h"
#import "FDLike.h"

@interface MainFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property NSArray *initialArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *userNameTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *likersTapGesture;
@property (nonatomic)  NSArray *recipeArray;
@property NSString *recipeId;
@property NSIndexPath *cellIndexPath;
@property Yummly *yummly;

@property (nonatomic) CGFloat lastContentOffsetY;
@end

@implementation MainFeedViewController

-(void)viewDidAppear:(BOOL)animated
{
    PFQuery *query = [FDTransaction query];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.recipeArray = objects;
        } else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

-(void)setRecipeArray:(NSMutableArray *)recipeArray
{
    _recipeArray = recipeArray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    self.title = @"FoodiCorn";

//    self.title = @"FOODiCORN";
    self.imageViewTapGesture = [UITapGestureRecognizer new];
    self.imageViewTapGesture.delegate = self;
    self.imageViewTapGesture.enabled = YES;

    self.userNameTapGesture = [UITapGestureRecognizer new];
    self.userNameTapGesture.delegate = self;
    self.userNameTapGesture.enabled = YES;

    self.likersTapGesture = [UITapGestureRecognizer new];
    self.likersTapGesture.delegate = self;
    self.likersTapGesture.enabled = YES;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recipeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainFeedCell"];
    FDTransaction *transaction = [self.recipeArray objectAtIndex:indexPath.row];
    self.recipeId = transaction.dishID;
    cell.usernameLabel.text = transaction.userName;

    NSDate *now = [NSDate date];
    //createdAt:"2011-06-10T18:33:42Z"
    NSDate *date2 = transaction.createdAt;
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    double minsInAnHour = 60;
    NSInteger minsBetweenDates = distanceBetweenDates / minsInAnHour;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    if (minsBetweenDates > 60) {
        if(hoursBetweenDates>24){
            NSInteger daysBetweenDates = hoursBetweenDates / 24;
            cell.timeLabel.text = [NSString stringWithFormat:@"%ldd",(long)daysBetweenDates];
        } else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%ldh",(long)hoursBetweenDates];
        }
    }else{
        cell.timeLabel.text = [NSString stringWithFormat:@"%ldm",(long)minsBetweenDates];
    }

//    self.cellIndexPath = indexPath;
//    NSLog(@"%li, %li", (long)self.cellIndexPath.row, (long)self.cellIndexPath.section);




    PFFile *dishImagePFile = transaction.dishImagePFFile;
    [dishImagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.mainFeedImageView.image = img;

        }
    }];

    //HAVE TO IMPORT THE AMOUNT OF LIKES A DISH HAS
    [FDLike likedByUsersWithCompletion:transaction.dishID completionHandler:^(NSArray *array) {
        cell.likesLabel.text = [NSString stringWithFormat:@"%ld Likes", (unsigned long)array.count];

    }];

    PFFile *userImagePFile = transaction.userProfileImagePFFile;
    [userImagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.userImage.image = img;

        }
    }];
    
    return cell;
}

//This will segue to detailVC
- (IBAction)imageViewTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC= [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];

    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    FDTransaction *transaction = [self.recipeArray objectAtIndex:indexPath.row];
    detailVC.recipeID = transaction.dishID;
}

- (IBAction)userNameTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
//    MainFeedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainFeedCell"];
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    FDPFUser *currentUser = [FDPFUser currentUser];
    FDTransaction *transaction = [self.recipeArray objectAtIndex:indexPath.row];

    if ([transaction.userName isEqualToString:currentUser.username])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
        ProfileViewController *profileVC= [storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        [self.navigationController pushViewController:profileVC animated:YES];

    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
        UserProfileViewController *userVC= [storyboard instantiateViewControllerWithIdentifier:@"UserVC"];
        userVC.user = transaction.user;
        [self.navigationController pushViewController:userVC animated:YES];

        //What are we passing onUsernameTapped

    }
}

-(void)getIndexPathFromLabel: (NSIndexPath *)indexPath
{

}

- (IBAction)likesTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
//    NSLog(@"%li", (long)indexPath.row);

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];
    FDTransaction *transaction = [self.recipeArray objectAtIndex:indexPath.row];
    [FDLike likedByUsersWithCompletion:transaction.dishID completionHandler:^(NSArray *array) {
        likersVC.usersArray = array;
    }];
    
    [self.navigationController pushViewController:likersVC animated:YES];

//    [self performSegueWithIdentifier:@"picturelikes" sender:self];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    LikersViewController *likersVC = segue.destinationViewController;
//
//    if ([segue.identifier isEqualToString:@"picturelikes"])
//    {
//        UIImage *img = [UIImage imageNamed:@"person"];
//        NSData *imgData = UIImagePNGRepresentation(img);
//        NSMutableArray *muteArray = [NSMutableArray new];
//
//        NSMutableDictionary *dict = [NSMutableDictionary new];
//        NSMutableDictionary *dict2 = [NSMutableDictionary new];
//
//        [dict setObject:imgData forKey:@"profileImage"];
//        [dict setObject:@"lady g" forKey:@"username"];
//        [dict setObject:@"Lady Gaga" forKey:@"fullname"];
//        [dict setObject:@"+ Follow" forKey:@"followingNSString"];
//
//        [dict2 setObject:imgData forKey:@"profileImage"];
//        [dict2 setObject:@"fresh prince" forKey:@"username"];
//        [dict2 setObject:@"Will Smith" forKey:@"fullname"];
//        [dict2 setObject:@"Following" forKey:@"followingNSString"];
//        [muteArray addObject:dict];
//        [muteArray addObject:dict2];


//        NSArray *usersArray = @[ @{@"userName" : @"lady g",
//                                   @"userFullName" : @"Lady Gaga",
//
//                                   @"following" : @"Following"
//                                   },
//                                 @{@"userName" : @"fresh prince",
//                                   @"userFullName" : @"Will Smith",
//                                   @"profileImage" : userImage,
//                                   @"following" : @"+ Follow"
//                                   },
//                                 @{@"userName" : @"Hannah Montana",
//                                   @"userFullName" : @"Miley Cyrus",
//                                   @"profileImage" : userImage,
//                                   @"following" : @"Following"
//                                   }
//
//                                ];
//        NSLog(@"%@", muteArray);
//        likersVC.usersArray = muteArray;
//    }else
//    {
//
//    }
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//
//{
//
//    self.lastContentOffsetY = scrollView.contentOffset.y;
//
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (self.lastContentOffsetY > scrollView.contentOffset.y)
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    } else if (self.lastContentOffsetY < scrollView.contentOffset.y)
//    {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//}


@end
