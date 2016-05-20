//
//  RootViewController.m
//  TLContrlPageTabStrip
//
//  Created by lichuanjun on 16/5/20.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import "RootViewController.h"
#import "UILabel+Common.h"
#import "UIColor+expanded.h"
#import "UIView+Frame.h"
#import "XTSegmentControl.h"

#import "Masonry.h"
#import "iCarousel.h"
#import "DXPopover.h"

#import "MenuCollectionViewCell.h"
#import "SubViewController1.h"
#import "SubViewController2.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kMySegmentControl_Height 44.0

// XTSegmentControl为顶部菜单的创建，其中showRightButton是为了扩展是否显示右边更多菜单的事件，并把事件的响应Block到页面进行实现，此事例就是响应弹出窗的效果展现
// iCarousel为内容区域的滑动效果
// DXPopover弹出窗的效果
// UICollectionView则用于弹出窗里面的菜单列表


@interface RootViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) XTSegmentControl *mySegmentControl;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) iCarousel *myCarousel;
@property (nonatomic, assign) NSInteger curSelectIndex;

@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, assign) CGFloat popoverWidth;

@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"PageTabStrip";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.titlesArray = [[NSArray alloc] initWithObjects:@"全部", @"互动", @"开源控件", @"文档", @"代码", @"高尔夫",@"主题",@"软件",@"股票", nil];
    
    //初始化一个popover用于弹窗效果的展示
    self.popover = [DXPopover new];
    self.popoverWidth = kScreen_Width - 20;
    
    __weak typeof(self) weakSelf = self;
    CGRect frame = self.view.bounds;
    
    //内容区滚动效果插件
    self.myCarousel = [[iCarousel alloc] initWithFrame:frame];
    self.myCarousel.dataSource = self;
    self.myCarousel.delegate = self;
    self.myCarousel.decelerationRate = 1.0;
    self.myCarousel.scrollSpeed = 1.0;
    self.myCarousel.type = iCarouselTypeLinear;
    self.myCarousel.pagingEnabled = YES;
    self.myCarousel.clipsToBounds = YES;
    self.myCarousel.bounceDistance = 0.2;
    [self.view addSubview:self.myCarousel];
    [self.myCarousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    //添加滑块
    __weak typeof(self.myCarousel) weakCarousel = self.myCarousel;
    self.mySegmentControl = [[XTSegmentControl alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, 44) Items:self.titlesArray showRightButton:YES selectedBlock:^(NSInteger index) {
        weakSelf.curSelectIndex = index;
        [weakCarousel scrollToItemAtIndex:index animated:YES];
        [weakSelf.myCollectionView reloadData];
    }];
    //当有右边键时 其响应的事件
    self.mySegmentControl.rightButtonBlock= ^(CGRect rightButtomRect)
    {
        //弹出插件的运用
        [weakSelf updateMyViewFrame];
        CGPoint startPoint = CGPointMake(CGRectGetMidX(rightButtomRect), CGRectGetMaxY(rightButtomRect) + 25);
        [weakSelf.popover showAtPoint:startPoint
                       popoverPostion:DXPopoverPositionDown
                      withContentView:weakSelf.myCollectionView
                               inView:weakSelf.view];
    };
    [self.view addSubview:self.mySegmentControl];
    
    //用于展示弹出效果里面的列表
    if (!self.myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreen_Width-40, 150) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor = [UIColor whiteColor];
        self.myCollectionView.showsHorizontalScrollIndicator = NO;
        self.myCollectionView.showsVerticalScrollIndicator = NO;
        [self.myCollectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MenuCollectionViewCell class])];
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//popver一些属性的设置
-(void)updateMyViewFrame
{
    CGRect tableViewFrame = self.myCollectionView.frame;
    tableViewFrame.size.width = self.popoverWidth;
    self.myCollectionView.frame = tableViewFrame;
    self.popover.contentInset = UIEdgeInsetsZero;
    self.popover.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Getter/Setter

- (NSArray *)titlesArray
{
    if (nil == _titlesArray) {
        _titlesArray = [[NSArray alloc] initWithObjects:@"全部", @"互动", @"开源控件", @"文档", @"代码", @"高尔夫", @"主题", @"软件", @"股票", nil];
    }
    return _titlesArray;
}

#pragma mark iCarousel

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return [self.titlesArray count];
}

//滚动时内容视图的加载
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    [self.mySegmentControl setScrollOffset:index];
    UIViewController *childContrll = [[SubViewController1 alloc] init];
    UIView *my = childContrll.view;
    switch (index) {
        case 0:
        {
            my.backgroundColor = [UIColor blackColor];
        }
            break;
        case 1:
        {
            my.backgroundColor = [UIColor redColor];
        }
            break;
        default:
        {
            childContrll = [[SubViewController2 alloc] init];
        }
            break;
    }
    
    return childContrll.view;
}

//滚动时 下划线的位置更新
- (void)carouselDidScroll:(iCarousel *)carousel {
    if (self.mySegmentControl) {
        [self.mySegmentControl moveIndexWithProgress];
    }
}

//更新滚动其它两个控件的位置
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    self.curSelectIndex = carousel.currentItemIndex;
    [self.myCollectionView reloadData];
    if (self.mySegmentControl) {
        self.mySegmentControl.currentIndex = carousel.currentItemIndex;
    }
}

#pragma UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MenuCollectionViewCell class]) forIndexPath:indexPath];
    NSString *model = [self.titlesArray objectAtIndex:indexPath.row];
    collectionCell.curMenuModel = model;
    
    if (self.curSelectIndex == indexPath.row) {
        collectionCell.backgroundColor = [UIColor brownColor];
    }
    else
    {
        collectionCell.backgroundColor = [UIColor whiteColor];
    }
    return collectionCell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreen_Width-40)/3, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.curSelectIndex = indexPath.row;
    //两个滚动的位置更新
    [self.myCarousel scrollToItemAtIndex:self.curSelectIndex animated:YES];
    [self.mySegmentControl selectIndex:self.curSelectIndex];
    //隐藏弹出窗
    [self.popover dismiss];
}

@end
