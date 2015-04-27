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
    self.tableView.allowsSelection = NO;
}

-(void)setUsersArray:(NSMutableArray *)usersArray
{
    _usersArray = usersArray;
    [self.tableView reloadData];
}


-(void)viewDidAppear:(BOOL)animated
{
    [FDLike allUsersWithCompletion:^(NSArray *array) {
//        NSMutableArray *tempArray = [array mutableCopy];
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:array];
//        NSSet *set = [NSSet setWithArray:tempArray];
        self.usersArray = [[orderedSet array]mutableCopy];
//        self.usersArray = [[set allObjects]mutableCopy];
    }];
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
    cell.favUsernameLabel.text = user.username;


    PFFile *imageFile = [user objectForKey:@"profileThumbnailPFFile"];
    [user fetchIfNeededInBackground];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.favUserImageView.image = image;
        }
    }];

    [FDLike likeDishesWithCompletion:user completionHandler:^(NSArray *array) {
        NSMutableArray *muteArray = [array mutableCopy];
        FDLike *like = [array objectAtIndex:indexPath.row];
        NSString *string = [NSString stringWithFormat:@"%lu Likes", (unsigned long)muteArray.count];
        cell.favLikeLabel.text = string;
        cell.favTimeLabel.text  = [FDUtility timeSince:like.updatedAt];

        [cell setCollectionData:muteArray];
    }];

    [cell setParentVC:self];
    
    return cell;
}


//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//
//{
//
//    self.lastContentOffsetY = scrollView.contentOffset.y;
//
//}
//
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//
//{
//
//    if (self.lastContentOffsetY > scrollView.contentOffset.y) {
//
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//
//    } else if (self.lastContentOffsetY < scrollView.contentOffset.y) {
//
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        
//    }
//    
//}



@end
