//
//  LIUCircleLayer.m
//  TestCellAnimation
//
//  Created by liujun on 15/11/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "LIUCircleLayer.h"
#import <UIKit/UIKit.h>

@implementation LIUCircleLayer

+ (LIUCircleLayer *)layoutWithFrame:(CGRect)frame {
    
    LIUCircleLayer *layer = [LIUCircleLayer new];
    layer.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    layer.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    [layer setNeedsDisplay];
    
    return layer;
}

- (void)drawInContext:(CGContextRef)ctx {
    
    CGContextAddArc(ctx, CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds), self.bounds.size.width*0.4, 0, M_PI*2, 0);
    CGContextSetFillColorWithColor(ctx,[UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
}

@end
