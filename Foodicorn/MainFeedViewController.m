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
#import "Yummly.h"

@interface MainFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property NSArray *initialArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageViewTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *userNameTapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *likersTapGesture;
@property Yummly *yummly;

@property (nonatomic) CGFloat lastContentOffsetY;
@end

@implementation MainFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    self.title = @"FOODiCORN";

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

    self.initialArray = @[ @{ @"cell": @"Cell A",
                           @"userImageName": @"person",
                           @"userName": @"tylorswift",
                           @"dishImage": @"food1",
                           @"timeSince":@"1d",
                              @"likes":@[@"1",@"2"]
                           },
                        @{ @"cell": @"Cell B",
                           @"userImageName": @"person2",
                           @"userName": @"ladygaga",
                           @"dishImage": @"food2",
                           @"timeSince":@"2d",
                           @"likes":@[@"1",@"2"]
                           },
                        @{ @"cell": @"Cell C",
                           @"userImageName": @"person3",
                           @"userName": @"U2",
                           @"dishImage": @"food3",
                           @"timeSince":@"4d",
                           @"likes":@[@"1",@"2"]
                           }
                        ];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.initialArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainFeedCell"];
    NSDictionary *dict = [self.initialArray objectAtIndex:indexPath.row];
    cell.usernameLabel.text = [dict objectForKey:@"userName"];
    cell.timeLabel.text = [dict objectForKey:@"timeSince"];
    cell.mainFeedImageView.image = [UIImage imageNamed:[dict objectForKey:@"dishImage"]];
    NSArray *likes = [dict objectForKey:@"likes"];
    cell.likesLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)likes.count];
    cell.userImage.image = [UIImage imageNamed:[dict objectForKey:@"userImageName"]];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
//    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
//    [self.navigationController pushViewController:detailVC animated:YES];
//}

//This will segue to detailVC
- (IBAction)imageViewTapGesture:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC= [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //need to replace initial array with parse array
    self.yummly = [self.initialArray objectAtIndex:indexPath.row];
    //need to write code to pass a yummly object from an array
    detailVC.recipeID = @"Melt-in-Your-Mouth-Chicken-1066441"  ;
}

- (IBAction)userNameTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
    [self performSegueWithIdentifier:@"userprofile" sender:self];
    //write code to pass user information to userprofileVC
}


- (IBAction)likesTapGestureOnTapped:(UITapGestureRecognizer *)sender
{
    [self performSegueWithIdentifier:@"picturelikes" sender:self];
    //write code in here to pass people who liked the picture
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{

    self.lastContentOffsetY = scrollView.contentOffset.y;

}





-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{

    if (self.lastContentOffsetY > scrollView.contentOffset.y) {

        [self.navigationController setNavigationBarHidden:NO animated:YES];

    } else if (self.lastContentOffsetY < scrollView.contentOffset.y) {

        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    
}


@end
