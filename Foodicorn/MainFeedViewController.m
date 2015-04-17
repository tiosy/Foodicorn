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

@interface MainFeedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property NSArray *initialArray;
@property NSArray *cellNames;
@property NSMutableArray *tableViewArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    cell.usernameLabel.text = [dict objectForKey:@"cell"];
    cell.timeLabel.text = [dict objectForKey:@"timeSince"];
    cell.mainFeedImageView.image = [UIImage imageNamed:[dict objectForKey:@"dishImage"]];
    NSArray *likes = [dict objectForKey:@"likes"];
    cell.likesLabel.text = [NSString stringWithFormat:@"%ld", likes.count];
    cell.userImage.image = [UIImage imageNamed:[dict objectForKey:@"userImageName"]];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
//    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
//    [self.navigationController pushViewController:detailVC animated:YES];
//}

- (IBAction)onLikeButtonTap:(id)sender
{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


@end
