//
//  TLButtonViewController.m
//  TestTLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLButtonViewController.h"
#import "TLUIFoundation/TLUIFoundation.h"
#import "Masonry/Masonry.h"

@interface TLButtonViewController ()

@end

@implementation TLButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 测试按钮
    [self testButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testButton {
    //    TLButtonBlock *button = [[TLButtonBlock alloc]initWithFrame:CGRectMake(100, 100, 100, 50) normalImageString:nil highlightImageString:nil];
    
    TLButtonBlock *button = [[TLButtonBlock alloc] init];
    [button setTitle:@"哈哈" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    
    [button addActionforControlEvents:UIControlEventTouchUpInside respond:^{
        NSLog(@"我被点了");
    }];
    
    [self.view addSubview:button];
    
    __weak typeof(self) weakSelf = self;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf.view).offset(100.f);
        make.left.equalTo(strongSelf.view).offset(20.f);
        make.width.equalTo(@(100.f));
        make.height.equalTo(@(50.f));
    }];
}

@end
