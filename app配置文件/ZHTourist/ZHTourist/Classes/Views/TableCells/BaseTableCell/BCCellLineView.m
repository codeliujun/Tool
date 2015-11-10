//
//  BCCellLineView.m
//  BookingCar
//
//  Created by Michael Shan on 14-11-10.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "BCCellLineView.h"

@implementation BCCellLineView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat lineWidth = 0.5;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetShouldAntialias(context, NO);
    CGContextSetStrokeColorWithColor(context, kLightCellDescColor.CGColor);
    CGContextMoveToPoint(context, 0, self.height-lineWidth);
    CGContextAddLineToPoint(context, self.width, self.height);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
