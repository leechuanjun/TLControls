//
//  TLButtonBlock.m
//  TLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLButtonBlock.h"
#import <objc/runtime.h>

static void *TLClickKey = @"TLClickKey";

@implementation TLButtonBlock

-(instancetype)init {
    self = [super init];
    if (self) {
        self = [TLButtonBlock buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
           normalImageString:(NSString *)normalImageString
        highlightImageString:(NSString *)highlightImageString {
    if (self = [super initWithFrame:frame]) {
        self = [TLButtonBlock buttonWithType:UIButtonTypeCustom];
        self.frame = frame;
        if (normalImageString) {
            [self setImage:[UIImage imageNamed:normalImageString] forState:UIControlStateNormal];
        }
        if (highlightImageString) {
            [self setImage:[UIImage imageNamed:highlightImageString] forState:UIControlStateHighlighted];
        }
    }
    return self;
}

- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(TLCompletionHandler)completion{
    
    [self addTarget:self action:@selector(didClickTL) forControlEvents:controlEvents];
    
    void (^block)(void) = ^{
        
        completion();
        
    };
    
    objc_setAssociatedObject(self, TLClickKey, block, OBJC_ASSOCIATION_COPY);
}

-(void) didClickTL {
    void (^block)(void) = objc_getAssociatedObject(self, TLClickKey);
    block();
}

@end
