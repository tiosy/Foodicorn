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

//    self.initialArray = @[ @{ @"cell": @"Cell A",
//                           @"userImageName": @"person",
//                           @"userName": @"tylorswift",
//                           @"numOfPosts": @"liked 5 posts",
//                           @"timeSince":@"1d",
//                           @"collections": @[ @{ @"dishImageName": @"food1" },
//                                              @{ @"dishImageName": @"food2"},
//                                              @{ @"dishImageName": @"food3"},
//                                              @{ @"dishImageName": @"food4"},
//                                              @{ @"dishImageName": @"food5"},
//                                              @{ @"dishImageName": @"food7"}
//                                              ]
//                           },
//                        @{ @"cell": @"Cell B",
//                           @"userImageName": @"person2",
//                           @"userName": @"ladygaga",
//                           @"numOfPosts": @"liked 6 posts",
//                           @"timeSince":@"2d",
//                           @"collections": @[ @{ @"dishImageName": @"food6"},
//                                              @{ @"dishImageName": @"food7"},
//                                              @{ @"dishImageName": @"food8"},
//                                              @{ @"dishImageName": @"food10"},
//                                              @{ @"dishImageName": @"food9"},
//                                              @{ @"dishImageName": @"food2"}
//                                              ]
//                           },
//                        @{ @"cell": @"Cell C",
//                           @"userImageName": @"person3",
//                           @"userName": @"U2",
//                           @"numOfPosts": @"liked 4 posts",
//                           @"timeSince":@"4d",
//                           @"collections": @[ @{ @"dishImageName": @"food3"},
//                                              @{ @"dishImageName": @"food5"},
//                                              @{ @"dishImageName": @"food7"},
//                                              @{ @"dishImageName": @"food8"}
//                                              ],
//                           @"recipeID" : @[@"Melt-in-Your-Mouth-Chicken-1066441",
//                                           @"Yaki-Udon-With-Beef-571964",
//                                           @"Vegetable-Sushi-Martha-Stewart",
//                                           ]
//
//
//                           }
//                        ];

}

-(void)setUsersArray:(NSMutableArray *)usersArray
{
    _usersArray = usersArray;
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [FDLike allUsersWithCompletion:^(NSArray *array) {
        NSMutableArray *tempArray = [array mutableCopy];
        NSSet *set = [NSSet setWithArray:tempArray];
        self.usersArray = [[set allObjects]mutableCopy];
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

    PFFile *imageFile = user.profileThumbnailPFFile;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.favUserImageView.image = image;
        }
    }];

    cell.favUsernameLabel.text = user.username;

//    cell.favLikeLabel.text = STILL WORKING ON THIS
    cell.favTimeLabel.text  = [FDUtility timeSince:user.createdAt];

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
