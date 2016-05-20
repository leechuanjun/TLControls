//
//  MenuCollectionViewCell.m
//  TLContrlPageTabStrip
//
//  Created by lichuanjun on 16/5/20.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import "MenuCollectionViewCell.h"
#import "Masonry.h"

@interface MenuCollectionViewCell()

@property(nonatomic, strong) UILabel *menuLabel;

@end

@implementation MenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (self.menuLabel == nil) {
            self.menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
            self.menuLabel.font = [UIFont systemFontOfSize:17];
            self.menuLabel.textAlignment = NSTextAlignmentCenter;
            self.menuLabel.text = @"test";
            [self.contentView addSubview:self.menuLabel];
            
            __weak typeof(self) weakSelf = self;
            [self.menuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf.contentView);
            }];
        }
    }
    return self;
}

-(void)setCurMenuModel:(NSString *)curMenuModel
{
    _curMenuModel = curMenuModel;
    self.menuLabel.text = curMenuModel;
}

@end
