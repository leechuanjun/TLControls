//
//  TLPieView.m
//  TLControlPieChart
//
//  Created by lichuanjun on 16/5/19.
//  Copyright © 2016年 lichuanjun. All rights reserved.
//

#import "TLPieView.h"

//半径
//#define radius 75
#define PI 3.14159265358979323846

@implementation TLPieView

//计算度转弧度
static inline float radians(double degrees) {
    return degrees * PI / 180;
}

static inline void drawArc(CGContextRef ctx, CGPoint point, float angle_start, float angle_end, UIColor* color, float radius) {
    CGContextMoveToPoint(ctx, point.x, point.y);
    CGContextSetFillColor(ctx, CGColorGetComponents( [color CGColor]));
    CGContextAddArc(ctx, point.x, point.y, radius,  angle_start, angle_end, 0);
    //CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

/**
 注意：绘制圆形和绘制扇形的原点不同
 
 */
-(void)drawRect:(CGRect)rect
{
    // 一、绘制圆形
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取图形上下文
//    CGPoint cent = CGPointMake(self.frame.size.width/2-radius, self.frame.size.height/2-radius);//设置图形开始画的坐标原点,根据实际需要设置，我这是随便写的
//    CGContextAddEllipseInRect(ctx, CGRectMake(cent.x, cent.y, 150, 150));//这个是核心函数，在这里设置图形的开始从哪里画，画的宽度和高度是多少。如果宽高不一样 可就是椭圆了啊
//    [[UIColor greenColor] set];//设置颜色
//    CGContextFillPath(ctx);//实心的
//    //CGContextStrokePath(ctx);空心的
    
    // 二、绘制扇形
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGPoint cent = CGPointMake((self.frame.size.width/2), (self.frame.size.height/2));
//    CGContextClearRect(ctx, rect);
//    NSLog(@"width=%f,height=%f",self.frame.size.width,self.frame.size.height);
//    NSLog(@"x=%f,y=%f",cent.x,cent.y);
//    
//    float angle_start = radians(0.0);
//    float angle_end = radians(120.0);
//    CGContextMoveToPoint(ctx, cent.x, cent.y);
//    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor greenColor] CGColor]));
//    CGContextAddArc(ctx, cent.x, cent.y, radius,  angle_start, angle_end, 0);
//    CGContextFillPath(ctx);
//    
//    angle_start = angle_end;
//    angle_end = radians(360.0);
//    CGContextMoveToPoint(ctx, cent.x, cent.y);
//    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
//    CGContextAddArc(ctx, cent.x, cent.y, radius,  angle_start, angle_end, 0);
//    CGContextFillPath(ctx);
    
    // 三、重构代码
    CGPoint cent=CGPointMake((self.frame.size.width/2), (self.frame.size.height/2));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    float angle_start = radians(0.0);
    float angle_end = radians(121.0);
    drawArc(ctx, cent, angle_start, angle_end, [UIColor yellowColor], self.radius);
    
    angle_start = angle_end;
    angle_end = radians(228.0);
    drawArc(ctx, cent, angle_start, angle_end, [UIColor greenColor], self.radius);
    
    angle_start = angle_end;
    angle_end = radians(260);
    drawArc(ctx, cent, angle_start, angle_end, [UIColor orangeColor], self.radius);
    
    angle_start = angle_end;
    angle_end = radians(360);
    drawArc(ctx, cent, angle_start, angle_end, [UIColor purpleColor], self.radius);
}

-(void)setRadius:(float)radius
{
    _radius=radius;
    [self setNeedsDisplay];
}

@end
