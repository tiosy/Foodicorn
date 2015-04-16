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

@interface FavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *favTableView;
@property NSArray *initialArray;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.initialArray = @[ @{ @"cell": @"Cell A",
                           @"userImageName": @"person",
                           @"userName": @"tylorswift",
                           @"numOfPosts": @"liked 5 posts",
                           @"timeSince":@"1d",
                           @"collections": @[ @{ @"dishImageName": @"food1" },
                                              @{ @"dishImageName": @"food2"},
                                              @{ @"dishImageName": @"food3"},
                                              @{ @"dishImageName": @"food4"},
                                              @{ @"dishImageName": @"food5"},
                                              @{ @"dishImageName": @"food7"}
                                              ]
                           },
                        @{ @"cell": @"Cell B",
                           @"userImageName": @"person2",
                           @"userName": @"ladygaga",
                           @"numOfPosts": @"liked 6 posts",
                           @"timeSince":@"2d",
                           @"collections": @[ @{ @"dishImageName": @"food6"},
                                              @{ @"dishImageName": @"food7"},
                                              @{ @"dishImageName": @"food8"},
                                              @{ @"dishImageName": @"food10"},
                                              @{ @"dishImageName": @"food9"},
                                              @{ @"dishImageName": @"food2"}
                                              ]
                           },
                        @{ @"cell": @"Cell C",
                           @"userImageName": @"person3",
                           @"userName": @"U2",
                           @"numOfPosts": @"liked 4 posts",
                           @"timeSince":@"4d",
                           @"collections": @[ @{ @"dishImageName": @"food3"},
                                              @{ @"dishImageName": @"food5"},
                                              @{ @"dishImageName": @"food7"},
                                              @{ @"dishImageName": @"food8"}
                                              ]
                           }
                        ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.initialArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteTableCell"];
    NSDictionary *dict = [self.initialArray objectAtIndex:indexPath.row];
    NSString *imageName = [dict objectForKey:@"userImageName"];
    cell.favUserImageView.image = [UIImage imageNamed:imageName];
    cell.favUsernameLabel.text = [dict objectForKey:@"userName"];
    cell.favLikeLabel.text = [dict objectForKey:@"numOfPosts"];
    cell.favTimeLabel.text  = [dict objectForKey:@"timeSince"];


    NSArray *collectionData = [dict objectForKey:@"collections"];
    [cell setCollectionData:collectionData];


    return cell;
}

@end
