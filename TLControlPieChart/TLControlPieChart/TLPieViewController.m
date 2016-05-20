//
//  TLPieViewController.m
//  TLControlPieChart
//
//  Created by lichuanjun on 16/5/19.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import "TLPieViewController.h"
#import "TLPieView.h"

@interface TLPieViewController ()

@end

@implementation TLPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TLPieView *pipView=[[TLPieView alloc] init];
    pipView.radius = 75;
    pipView.frame = CGRectMake(15, (SCREEN_HEIGHT-400)/2.f, SCREEN_WIDTH-30, 400);
    [self.view addSubview:pipView];
    
    //模拟5秒后执行这个段代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pipView.radius = 40;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
