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
#import "SearchViewController.h"

@interface JustinViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)  NSArray *recipes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property Yummly *yummly;

@property NSMutableArray *thumbnailImages;


@end

@implementation JustinViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.thumbnailImages = [NSMutableArray new];

    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];


    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:indicator];
    self.navigationItem.rightBarButtonItem = rightItem;
    [indicator startAnimating];
    [Yummly recipeArrayFromDictionaryArray:self.urlText completeHandler:^(NSArray *array) {
        self.recipes = array;

        if (self.recipes.count == 0)
        {
            [self showAlert];
        }

        for (Yummly *yummly in self.recipes) {
            NSString *thumbnailString = yummly.thumbnailString;
            NSURL *url = [NSURL URLWithString:thumbnailString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];

            [self.thumbnailImages addObject:image];

        }

        self.title = @"Search Results";

        NSLog(@"%@", self.recipes);

        [indicator stopAnimating];
    }];

}

-(void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Results" message:@"Sorry, we could not find any recipes for your specified search. Please check your search and try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)setRecipes:(NSArray *)recipes
{
    _recipes = recipes;
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipe"];
    Yummly *yummly = [self.recipes objectAtIndex:indexPath.row];
    cell.textLabel.text = yummly.recipeName;
    cell.detailTextLabel.text = yummly.sourceId;
    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    } else
    {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }

    cell.imageView.image = self.thumbnailImages[indexPath.row];
    cell.imageView.frame = CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50, 50, 50);
    cell.imageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
    cell.imageView.layer.borderWidth = 1.0f;
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
    cell.imageView.layer.masksToBounds = YES;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recipes.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC= [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
    self.yummly = [self.recipes objectAtIndex:indexPath.row];
    detailVC.recipeID = self.yummly.recipeId;
}

//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if (velocity.y > 0) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    } else if (velocity.y < 0){
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}
@end

