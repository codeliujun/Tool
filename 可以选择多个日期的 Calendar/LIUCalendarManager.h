//
//  LIUCalendarManager.h
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIUWeekView.h"
#import "LIUContentView.h"
#import "LIUMouthView.h"

@interface LIUCalendarManager : NSObject<LIUMouthViewDelegate>


@property(nonatomic,weak)LIUWeekView *weekView;
@property(nonatomic,weak)LIUContentView *contentView;
@property(nonatomic,weak)LIUMouthView *mouthView;

@property(nonatomic,strong)NSMutableArray *didSelectDate;
@property(nonatomic,assign)BOOL isMultySelect;//默认是no

- (void)reloadData;
- (void)loadPreviousMouth;
- (void)loadNextMouth;

- (NSString *)getWeekStrWithDate:(NSDate *)date;

@end
