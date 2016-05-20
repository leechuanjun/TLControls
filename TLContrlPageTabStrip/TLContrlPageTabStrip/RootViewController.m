//
//  RootViewController.m
//  TLContrlPageTabStrip
//
//  Created by lichuanjun on 16/5/20.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import "RootViewController.h"
#import "TLUIFoundation/TLUIFoundation.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kMySegmentControl_Height 44.0

// XTSegmentControl为顶部菜单的创建，其中showRightButton是为了扩展是否显示右边更多菜单的事件，并把事件的响应Block到页面进行实现，此事例就是响应弹出窗的效果展现
// iCarousel为内容区域的滑动效果
// DXPopover弹出窗的效果
// UICollectionView则用于弹出窗里面的菜单列表


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"PageTabStrip";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
