//
//  LIUContentView.h
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUContentView : UIView

- (void)upDateContentWithFirstWeekDay:(NSInteger)firstWeekDay AndMouthDays:(NSInteger)mouthDays AndDates:(NSArray *)dates;

- (void)upDateContentWithDates:(NSArray *)dates;

@end
