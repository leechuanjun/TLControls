//
//  TLCollectionViewDataSource.h
//  TLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 数据源,代理回调block*/

typedef void (^shouldHighlight)(NSIndexPath*);
typedef void (^didSelect)(NSIndexPath *indexPath);
typedef void (^didHighlight)(NSIndexPath *indexPath);
typedef void (^didDeselectRow)(NSIndexPath *indexPath);
typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);

@interface TLCollectionViewDataSource : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, copy) didSelect didSelect;
@property(nonatomic, copy) didHighlight  didHighlight;
@property(nonatomic, strong) shouldHighlight shouldHighlight;
@property(nonatomic, strong) didDeselectRow didDeselectRow;

// 初始化方法
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
           itemSize:(CGSize)itemSize;

// 根据indexPath取得对应的item
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
