//
//  FavView.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FavView.h"
#import "FavoriteViewController.h"
#import "FavCollectionViewCell.h"
#import "DetailViewController.h"
#import "Yummly.h"

@interface FavView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end

@implementation FavView

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {

    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];

    self.collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    NSString *imageName = [cellData objectForKey:@"dishImageName"];
    cell.favFoodImageView.image =  [UIImage imageNamed:imageName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.parentVC presentViewController:detailVC animated:YES completion:nil];
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    NSString *imageName = [cellData objectForKey:@"dishImageName"];
    NSLog(@"%@", imageName);


    NSLog(@"collection cell selected %ld", indexPath.row);

}
@end
