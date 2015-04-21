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

#import <parse/PFObject+Subclass.h>
#import "FDTransaction.h"

@interface MainFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property NSArray *initialArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *userNameTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *likersTapGesture;
@property (nonatomic)  NSArray *recipeArray;
@property NSString *recipeId;

@property Yummly *yummly;

@property (nonatomic) CGFloat lastContentOffsetY;
@end

@implementation MainFeedViewController

-(void)viewWillAppear:(BOOL)animated
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

//    self.initialArray = @[ @{ @"cell": @"Cell A",
//                           @"userImageName": @"person",
//                           @"userName": @"tylorswift",
//                           @"dishImage": @"food1",
//                           @"timeSince":@"1d",
//                              @"likes":@[@"1",@"2"]
//                           },
//                        @{ @"cell": @"Cell B",
//                           @"userImageName": @"person2",
//                           @"userName": @"ladygaga",
//                           @"dishImage": @"food2",
//                           @"timeSince":@"2d",
//                           @"likes":@[@"1",@"2"]
//                           },
//                        @{ @"cell": @"Cell C",
//                           @"userImageName": @"person3",
//                           @"userName": @"U2",
//                           @"dishImage": @"food3",
//                           @"timeSince":@"4d",
//                           @"likes":@[@"1",@"2"]
//                           }
//                        ];
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
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    cell.timeLabel.text = [NSString stringWithFormat:@"%ldh",(long)hoursBetweenDates];

    PFFile *dishImagePFile = transaction.dishImagePFFile;
    [dishImagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.mainFeedImageView.image = img;

        }
    }];
    //have to work on getting count
    cell.likesLabel.text = [NSString stringWithFormat:@"%d",transaction.likedBy.count];
    NSLog(@"The cell text is %lu", (unsigned long)transaction.likedBy.count);

    PFFile *userImagePFile = transaction.userProfileImagePFFile;
    [userImagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.userImage.image = img;

        }
    }];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
//    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    FDTransaction *transaction = [self.recipeArray objectAtIndex:indexPath.row];
//    detailVC.recipeID = transaction.dishID;
//
//    NSLog(@"%d", indexPath.row);
//}

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
        [self.navigationController pushViewController:userVC animated:YES];
    //    [self performSegueWithIdentifier:@"userprofile" sender:self];
        //write code to pass user information to userprofileVC
        //pass username to userprofileVC


    }
}


- (IBAction)likesTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
    [self performSegueWithIdentifier:@"picturelikes" sender:self];
    //write code in here to pass people who liked the picture
}

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
