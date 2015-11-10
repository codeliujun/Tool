//
//  LIUQueueStruct.m
//  TestCellAnimation
//
//  Created by liujun on 15/11/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "LIUQueueStruct.h"

@interface LIUQueueStruct ()

@property (nonatomic,strong)NSMutableArray *values;

@end

@implementation LIUQueueStruct

- (NSMutableArray *)values {
    if (!_values) {
        _values = @[].mutableCopy;
    }
    return _values;
}

- (void)addValue:(id)value {
    
    if (!value) {
        return;
    }
    
    [self.values addObject:value];
    
}
- (id)getValue {
    
    if (self.values.count == 0) {
        return nil;
    }
    
    id obj = self.values.firstObject;
    [self.values removeObject:obj];
    
    return obj;
}

- (void)clearQueue {
    
    [self.values removeAllObjects];
    
}

@end
