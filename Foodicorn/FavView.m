//
//  FavView.m
//  Foodicorn
//
//  Created by Jazz Santiago on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FavView.h"
#import "FavCollectionViewCell.h"

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
//    cell.imageFood.image =  [UIImage imageNamed:imageName];
    return cell;
}
@end
