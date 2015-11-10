//
//  UIButton+Block.m
//  BookingCar
//
//  Created by Michael Shan on 14-10-1.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton (Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

@end
