//
//  LikersViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "LikersViewController.h"

@interface LikersViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray *usersArray;

@end

@implementation LikersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usersArray = @[ @{@"userImageName" : @"person",
                           @"userName" : @"Taylor S.",
                           @"userFullName" : @"Taylor Swift",
                           @"following" : @"YES"
                           },
                         @{@"userImageName" : @"person2",
                           @"userName" : @"Lady G",
                           @"userFullName" : @"Lady Gaga",
                           @"following" : @"YES"
                           },
//                         @{@"userImageName" : @"person3",
//                           @"userName" : @"Hannah Montana",
//                           @"userFullName" : @"Miley Cyrus",
//                           @"following" : @"NO"
//                           }
                        ];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code for likers of photo or followers of user or the people whom a user follows
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    NSDictionary *dict = [self.usersArray objectAtIndex:indexPath.row];
    NSString *image = [dict objectForKey:@"userImageName"];
    cell.imageView.image = [UIImage imageNamed:image];
    cell.textLabel.text = [dict objectForKey:@"userName"];
    cell.detailTextLabel.text = [dict objectForKey:@"userFullName"];
                             
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

@end
