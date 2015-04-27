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
#import "FDLike.h"
#import "Yummly.h"

@interface FavView () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
    self.collectionView.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.minimumLineSpacing = 1.0;

    
//    self.collectionView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:1].CGColor;
//    self.collectionView.layer.borderWidth = 2.0f;
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
    FDLike *like = [self.collectionData objectAtIndex:[indexPath row]];

    PFFile *imageFile = [like objectForKey:@"imagePFFile"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        UIImage *image = [UIImage imageWithData:data];
        cell.favFoodImageView.image = image;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    DetailViewController *detailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [self.parentVC showViewController:detailVC sender:self];

    FDLike *like = [self.collectionData objectAtIndex:indexPath.row];
    detailVC.recipeID = like.from;


//    NSLog(@"collection cell selected %ld", indexPath.row);

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.frame.size.width - 2)/2.5, (self.collectionView.frame.size.width - 2)/2.5);
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

@end
