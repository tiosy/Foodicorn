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

#import "Constants.h"

//Utilities
#import "FDUtility.h"

//API
#import "Yummly.h"

//Parse
#import <parse/PFObject+Subclass.h>
#import "FDDish.h"
#import "FDPFUser.h"
#import "FDTransaction.h"
#import "FDLike.h"

@interface MainFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property NSArray *initialArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *userNameTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *likersTapGesture;
@property (nonatomic)  NSArray *recipeArray;
@property (nonatomic)  NSMutableArray *likersArray;
@property NSString *recipeId;
@property NSIndexPath *cellIndexPath;
@property Yummly *yummly;

@property UIRefreshControl *refreshControl;

@property (nonatomic) CGFloat lastContentOffsetY;
@end

@implementation MainFeedViewController


-(void)viewDidAppear:(BOOL)animated
{
    PFQuery *query = [FDTransaction query];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){
            self.recipeArray = objects;
        } else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    //move load to viewDidLoad to avoid flicking
    //reload if needed ...How?



}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    //self.title = @"Food🍓🍦Corn";
    self.title = @"Food🍭Corn";
    self.likersArray = [NSMutableArray new];

    self.imageViewTapGesture = [UITapGestureRecognizer new];
    self.imageViewTapGesture.delegate = self;
    self.imageViewTapGesture.enabled = YES;

    self.userNameTapGesture = [UITapGestureRecognizer new];
    self.userNameTapGesture.delegate = self;
    self.userNameTapGesture.enabled = YES;

    self.likersTapGesture = [UITapGestureRecognizer new];
    self.likersTapGesture.delegate = self;
    self.likersTapGesture.enabled = YES;

    self.refreshControl = [UIRefreshControl new];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //Load Transansactions into Mainfeed
    FDPFUser *me = [FDPFUser currentUser];
    NSLog(@"%@",me.username);

}
-(void)setRecipeArray:(NSMutableArray *)recipeArray
{
    _recipeArray = recipeArray;
    [self.tableView reloadData];
}


-(void)refreshTable
{
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
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

    //calculate time Since... (for example 1m or 2h or 2d)
    cell.timeLabel.textColor=kFoodiCornNavBarColor;
    cell.timeLabel.text = [FDUtility timeSince:transaction.createdAt];

    PFFile *dishImagePFile = transaction.dishImagePFFile;
    [dishImagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
        if (!error) {
            UIImage *img = [UIImage imageWithData:imageNSData];
            cell.mainFeedImageView.image = img;

        }
    }];

    //HAVE TO IMPORT THE AMOUNT OF LIKES A DISH HAS
    [FDLike likedByUsersWithCompletion:[transaction objectForKey:@"dishID"]  completionHandler:^(NSArray *array) {
        cell.likesLabel.text = [NSString stringWithFormat:@"%ld Likes", (unsigned long)array.count];
        self.likersArray[indexPath.row] = array;

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
        userVC.user = [transaction objectForKey:@"user"];
        [self.navigationController pushViewController:userVC animated:YES];

        //What are we passing onUsernameTapped

    }
}


- (IBAction)likesTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
    LikersViewController *likersVC = [storyboard instantiateViewControllerWithIdentifier:@"likersVC"];

    likersVC.usersArray = [self.likersArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:likersVC animated:YES];
}



@end
