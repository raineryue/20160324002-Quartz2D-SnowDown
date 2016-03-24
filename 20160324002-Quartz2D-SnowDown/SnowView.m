//
//  SnowView.m
//  20160324002-Quartz2D-SnowDown
//
//  Created by Rainer on 16/3/24.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "SnowView.h"

static CGFloat _snowY;

@implementation SnowView


/**
 *  如果需要绘图必须要在本方法中完成，只能在这里才能拿到图形上下文
 */
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"雪花"];
    
    [image drawAtPoint:CGPointMake(100, _snowY)];
    
    _snowY += 10;
    
    if (_snowY >= rect.size.height) {
        _snowY = 0;
    }
}

/**
 *  此方法中拿不到图形上下文
 */
- (void)awakeFromNib {
    // 创建一个定时器：NSTimer很少用于绘图，因为它的调度优先级比较低，并不会被准时调用
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerCahnged) userInfo:nil repeats:YES];
    
    // 这个定时器一般用于游戏和绘图
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerCahnged)];
    
    // 加入到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

/**
 *  这个是CADisplayLink的事件方法，每次屏幕刷新是都会调用，屏幕一秒刷新60次
 */
- (void)timerCahnged {
    // 注意：这个方法并不会马上调用drawRect方法，只是给当前控件添加一个刷新的标记，当下一次屏幕刷新时就会调用drawRect方法
    [self setNeedsDisplay];
}

@end
