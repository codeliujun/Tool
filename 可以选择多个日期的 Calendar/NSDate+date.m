//
//  NSDate+date.m
//  LIUCalendar
//
//  Created by liujun on 15/7/12.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "NSDate+date.h"
#import <objc/runtime.h>

static const NSString *otherMouth = @"otherMouth";
static const NSString *isDidSelect = @"isSelect";

@implementation NSDate (date)

- (void)setIsOtherMouth:(NSNumber *)isOtherMouth {
    objc_setAssociatedObject(self, &otherMouth, isOtherMouth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)isOtherMouth {
    return objc_getAssociatedObject(self, &otherMouth);
}

- (void)setIsSelect:(NSNumber *)isSelect {
    objc_setAssociatedObject(self, &isDidSelect, isSelect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)isSelect {
    return objc_getAssociatedObject(self, &isDidSelect);
}


@end
