//
//  TLCollectionCell.m
//  TestTLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLCollectionCell.h"
#import "Masonry/Masonry.h"

@interface TLCollectionCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLCollectionCell

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

@end
