//
//  ViewController.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "JustinViewController.h"
#import "Yummly.h"
#import "DetailViewController.h"

@interface JustinViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)  NSArray *recipes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property Yummly *yummly;


@end

@implementation JustinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Yummly recipeArrayFromDictionaryArray:self.urlText completeHandler:^(NSArray *array) {
        self.recipes = array;

        NSLog(@"%@", self.recipes);
    }];


    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];


}

-(void)setRecipes:(NSArray *)recipes
{
    _recipes = recipes;
    [self.tableView reloadData];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipe"];
    self.yummly = [self.recipes objectAtIndex:indexPath.row];
    cell.textLabel.text = self.yummly.recipeName;
    cell.detailTextLabel.text = self.yummly.sourceId;

    NSString *thumnailImage = self.yummly.thumbnailString;
    NSURL *url = [NSURL URLWithString:thumnailImage];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recipes.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    self.yummly = [self.recipes objectAtIndex:indexPath.row];
    detailVC.recipeID = self.yummly.recipeId ;
}

@end

