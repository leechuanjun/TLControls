//
//  TLCollectionViewDataSource.m
//  TLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLCollectionViewDataSource.h"

@interface TLCollectionViewDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation TLCollectionViewDataSource

#pragma mark - Init

- (instancetype)init {
    
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
           itemSize:(CGSize)itemSize
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.itemSize = itemSize;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.items.count == 0) {
        
        NSLog(@"数组为空啦!!!");
    }
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    id item = [self itemAtIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell,item);
    }
    return cell;
    
}
#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didDeselectRow) {
        self.didDeselectRow(indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didSelect) {
        self.didSelect(indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didHighlight) {
        self.didHighlight(indexPath);
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}

@end
