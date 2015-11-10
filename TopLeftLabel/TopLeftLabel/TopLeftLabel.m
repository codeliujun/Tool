//
//  TopLeftLabel.m
//  TopLeftLabel
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "TopLeftLabel.h"

@implementation TopLeftLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    //获取label的大小，然后将drawTextInRect的Rect的y放到左顶点
    
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = 0;
    return textRect;

}

- (void)drawTextInRect:(CGRect)rect {
    
    CGRect drawRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:drawRect];
    
}


@end
