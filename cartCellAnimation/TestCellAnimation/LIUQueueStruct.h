//
//  LIUQueueStruct.h
//  TestCellAnimation
//
//  Created by liujun on 15/11/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import <Foundation/Foundation.h>

//队列数据结构，先进先出
@interface LIUQueueStruct : NSObject

- (void)addValue:(id)value;
- (id)getValue;
- (void)clearQueue;


@end
