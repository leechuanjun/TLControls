//
//  TLPieView.h
//  TLControlPieChart
//
//  Created by lichuanjun on 16/5/19.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define SCREEN_SCALE        [[UIScreen mainScreen] scale]

@interface TLPieView : UIView

@property(nonatomic, assign) float radius;

@end
