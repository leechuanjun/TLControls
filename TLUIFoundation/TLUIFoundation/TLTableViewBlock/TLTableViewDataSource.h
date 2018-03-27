//
//  TLTableViewDataSource.h
//  TLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^shouldHighlight)(NSIndexPath*);
typedef void (^didSelect)(NSIndexPath *indexPath);
typedef void (^didHighlight)(NSIndexPath *indexPath);
typedef void (^didDeselectRow)(NSIndexPath *indexPath);
typedef void (^TableViewCellConfigureBlock)(id cell, id item);


@interface TLTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy) didSelect didSelect;
@property(nonatomic,copy) didHighlight  didHighlight;
@property(nonatomic,strong) shouldHighlight shouldHighlight;
@property(nonatomic,strong) didDeselectRow didDeselectRow;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
         itemHeight:(float)itemHeight;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
