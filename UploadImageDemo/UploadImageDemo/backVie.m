//
//  backVie.m
//  UploadImageDemo
//
//  Created by liujun on 15/10/16.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "backVie.h"

@implementation backVie

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        NSLog(@"frame");
        self.frame = CGRectMake(0, 0, 100, 100);
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
