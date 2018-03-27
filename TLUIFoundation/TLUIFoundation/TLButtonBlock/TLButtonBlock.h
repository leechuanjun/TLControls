//
//  TLButtonBlock.h
//  TLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^TLCompletionHandler)(void);

@interface TLButtonBlock : UIButton

// 初始化
-(instancetype)initWithFrame:(CGRect)frame
           normalImageString:(NSString *)normalImageString
        highlightImageString:(NSString *)highlightImageString;

// 按钮触发
- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(TLCompletionHandler)completion;

@end
