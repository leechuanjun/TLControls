//
//  SegmentControl.m
//  GT
//
//  Created by tage on 14-2-26.
//  Copyright (c) 2014年 cn.kaakoo. All rights reserved.
//

#import "XTSegmentControl.h"

#import "Masonry.h"
#import "UILabel+Common.h"
#import "UIColor+expanded.h"
#import "UIView+Frame.h"

#define XTSegmentControlItemFont (18)

#define XTSegmentControlHspace (12)

#define XTSegmentControlLineHeight (2)

#define XTSegmentControlAnimationTime (0.3)

#define XTSegmentControlIconWidth (50.0)

#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define kScreen_Width [UIScreen mainScreen].bounds.size.width

typedef NS_ENUM(NSInteger, XTSegmentControlItemType)
{
    XTSegmentControlItemTypeTitle = 0,
    XTSegmentControlItemTypeIconUrl
};

@interface XTSegmentControlItem : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleIconView;
@property (nonatomic, assign) XTSegmentControlItemType itemType;


- (void)setSelected:(BOOL)selected;

@end

@implementation XTSegmentControlItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title type:(XTSegmentControlItemType)type
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.itemType = type;
        switch (self.itemType) {
            case XTSegmentControlItemTypeTitle:
            default:
            {
                self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, 0, CGRectGetWidth(self.bounds) - 2 * XTSegmentControlHspace, CGRectGetHeight(self.bounds))];
                self.titleLabel.font = [UIFont systemFontOfSize:XTSegmentControlItemFont];
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.text = title;
                self.titleLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
                self.titleLabel.backgroundColor = [UIColor clearColor];
                [self addSubview:self.titleLabel];
            }
                break;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    switch (self.itemType) {
        case XTSegmentControlItemTypeIconUrl:
        {
        }
            break;
        case XTSegmentControlItemTypeTitle:
        default:
        {
            if (self.titleLabel) {
                [self.titleLabel setTextColor:(selected? [UIColor colorWithHexString:@"0x3bbd79"]:[UIColor colorWithHexString:@"0x222222"])];
            }
        }
            break;
    }
}


@end



@interface XTSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *leftShadowView;
@property (nonatomic, strong) UIView *rightShadowView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *itemFrames;
@property (nonatomic, strong) NSMutableArray *itemSegmentCtrls;
@property (nonatomic, assign) id <XTSegmentControlDelegate> delegate;
@property (nonatomic, copy) XTSegmentControlBlock block;

//是否显示左边
@property (nonatomic, assign) BOOL showRightButton;

@end


static const CGFloat rightButtonWidth=40;

@implementation XTSegmentControl

- (id)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem
{
    if (self = [super initWithFrame:frame]) {
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.contentScrollView.width = self.showRightButton?self.bounds.size.width-rightButtonWidth:self.bounds.size.width;
        self.contentScrollView.backgroundColor = [UIColor clearColor];
        self.contentScrollView.delegate = self;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.scrollsToTop = NO;
        [self addSubview:self.contentScrollView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        [self.contentScrollView addGestureRecognizer:tapGes];
        [tapGes requireGestureRecognizerToFail:self.contentScrollView.panGestureRecognizer];
        
        
        if (self.showRightButton) {
            if (self.rightButton == nil) {
                self.rightButton=[[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-rightButtonWidth, self.bounds.origin.y, rightButtonWidth, self.bounds.size.height)];
                self.rightButton.adjustsImageWhenDisabled = NO;
                [self.rightButton setImage:[UIImage imageNamed:@"icon_more.png"] forState:UIControlStateNormal];
                [self.rightButton addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:self.rightButton];
            }
        }

        [self initItemsWithTitleArray:titleItem];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id<XTSegmentControlDelegate>)delegate
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem showRightButton:(BOOL)isShowButton selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    self.showRightButton = isShowButton;
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.block = selectedHandle;
    }
    return self;
}

- (void)doTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    __weak typeof(self) weakSelf = self;
    [self.itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect rect = [obj CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            [weakSelf selectIndex:idx];
            [weakSelf transformAction:idx];
            *stop = YES;
        }
    }];
}

-(void)sortButtonClick:(id)sender
{
    UIButton *rightButtom = (UIButton *)sender;
    if(self.rightButtonBlock)
    {
        self.rightButtonBlock(rightButtom.frame);
    }
}

- (void)transformAction:(NSInteger)index
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(XTSegmentControlDelegate)] && [self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
        [self.delegate segmentControl:self selectedIndex:index];
    } else if (self.block) {
        self.block(index);
    }
}

- (void)initItemsWithTitleArray:(NSArray *)titleArray
{
    self.itemFrames = [[NSMutableArray alloc] init];
    self.itemSegmentCtrls = [[NSMutableArray alloc] init];
    float y = 0;
    float height = CGRectGetHeight(self.bounds);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:XTSegmentControlItemFont]};
    
    NSObject *obj = [titleArray firstObject];
    if ([obj isKindOfClass:[NSString class]]) {
        for (int i = 0; i < titleArray.count; i++) {
            NSString *title = titleArray[i];
            CGSize size = [title sizeWithAttributes:attributes];
            
            float x = i > 0 ? CGRectGetMaxX([self.itemFrames[i-1] CGRectValue]) : 0;
            float width = 2 * XTSegmentControlHspace + size.width;
            CGRect rect = CGRectMake(x, y, width, height);
            [self.itemFrames addObject:[NSValue valueWithCGRect:rect]];
        }
        
        for (int i = 0; i < titleArray.count; i++) {
            CGRect rect = [self.itemFrames[i] CGRectValue];
            NSString *title = titleArray[i];
            XTSegmentControlItem *item = [[XTSegmentControlItem alloc] initWithFrame:rect title:title type:XTSegmentControlItemTypeTitle];
            if (i == 0) {
                [item setSelected:YES];
            }
            [self.itemSegmentCtrls addObject:item];
            [self.contentScrollView addSubview:item];
        }
    }
    
    [self.contentScrollView setContentSize:CGSizeMake(CGRectGetMaxX([[self.itemFrames lastObject] CGRectValue])+(self.showRightButton?rightButtonWidth:0), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
}

- (void)addRedLine
{
    if (!self.lineView) {
        CGRect rect = [self.itemFrames[0] CGRectValue];
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight)];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"0x3bbd79"];
        [self.contentScrollView addSubview:self.lineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rect)-0.5, CGRectGetWidth(self.bounds), 0.5)];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0xc8c7cc"];
        [self addSubview:bottomLineView];
    }
}

- (void)selectIndex:(NSInteger)index
{
    [self addRedLine];
    if (index != self.currentIndex) {
        XTSegmentControlItem *curItem = [self.itemSegmentCtrls objectAtIndex:index];
        CGRect rect = [self.itemFrames[index] CGRectValue];
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
            self.lineView.frame = lineRect;
        } completion:^(BOOL finished) {
            [self.itemSegmentCtrls enumerateObjectsUsingBlock:^(XTSegmentControlItem *item, NSUInteger idx, BOOL *stop) {
                [item setSelected:NO];
            }];
            [curItem setSelected:YES];
            self.currentIndex = index;
        }];
    }
    [self setScrollOffset:index];
}

- (void)moveIndexWithProgress
{
    CGRect origionRect = [self.itemFrames[self.currentIndex] CGRectValue];
    
    CGRect origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + XTSegmentControlHspace, CGRectGetHeight(origionRect) - XTSegmentControlLineHeight, CGRectGetWidth(origionRect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
    
    //增加下划线滚动的效果
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.frame = origionLineRect;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex != _currentIndex) {
        XTSegmentControlItem *preItem = [self.itemSegmentCtrls objectAtIndex:_currentIndex];
        XTSegmentControlItem *curItem = [self.itemSegmentCtrls objectAtIndex:currentIndex];
        [preItem setSelected:NO];
        [curItem setSelected:YES];
        _currentIndex = currentIndex;
    }
}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

- (void)setScrollOffset:(NSInteger)index
{
    if (self.contentScrollView.contentSize.width <= kScreen_Width) {
        return;
    }
    
    CGRect rect = [self.itemFrames[index] CGRectValue];
    float midX = CGRectGetMidX(rect);
    float offset = 0;
    float contentWidth = self.contentScrollView.contentSize.width;
    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;
    if (midX < halfWidth) {
        offset = 0;
    }else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    }else{
        offset = midX - halfWidth;
    }
    
    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        [self.contentScrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }];
}

@end

