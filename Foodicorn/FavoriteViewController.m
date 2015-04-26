//
//  FavoriteViewController.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavCollectionViewCell.h"
#import "FavTableViewCell.h"
#import "DetailViewController.h"
#import "FDLike.h"
#import "FDUtility.h"
#import "FDPFUser.h"

@interface FavoriteViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic)  NSMutableArray *usersArray;
@property (nonatomic) CGFloat lastContentOffsetY;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Like Activity";

    //get all unique users (remove duplicates)
    [FDLike allUsersWithCompletion:^(NSArray *array) {
        NSMutableArray *tempArray = [array mutableCopy];
        NSSet *set = [NSSet setWithArray:tempArray];
        self.usersArray = [[set allObjects]mutableCopy];
    }];

}

-(void)setUsersArray:(NSMutableArray *)usersArray
{
    _usersArray = usersArray;
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    //run in vidDidLoad to avoid flickering
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteTableCell"];
    FDPFUser *user = [self.usersArray objectAtIndex:indexPath.row];
    [user fetchIfNeededInBackground];

    //PFFile *imageFile = user.profileThumbnailPFFile;
    PFFile *imageFile = [user objectForKey:@"profileThumbnailPFFile"];
    [user fetchIfNeededInBackground];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.favUserImageView.image = image;
        }
    }];

    cell.favUsernameLabel.text = user.username;
    cell.favTimeLabel.text  = [FDUtility timeSince:user.createdAt];

    //get all dishes for this user
    [FDLike likeDishesWithCompletion:user completionHandler:^(NSArray *array) {
        [cell setCollectionData:array];
    }];




    [cell setParentVC:self];
    
    return cell;
}
- (IBAction)onTapGestureTapped:(UITapGestureRecognizer *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];



    //pass the yummly object here
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
