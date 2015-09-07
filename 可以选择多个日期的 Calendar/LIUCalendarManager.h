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


@property(nonatomic,weak)LIUWeekView *weekView; //显示星期
@property(nonatomic,weak)LIUContentView *contentView; //显示日期
@property(nonatomic,weak)LIUMouthView *mouthView; //显示月份

@property(nonatomic,strong)NSMutableArray *didSelectDate;
@property(nonatomic,assign)BOOL isMultySelect;//默认是no
@property(nonatomic,assign)BOOL isContinuousSelection;//默认是NO

- (void)reloadData;
- (void)loadPreviousMouth;
- (void)loadNextMouth;

- (NSString *)getWeekStrWithDate:(NSDate *)date;
- (NSString *)getTimeStrWithArray:(NSArray *)array; //获取一个时间数组中得字符
- (NSString *)getTotalStrWithDate:(NSDate *)date WithOffSymbol:(NSString *)symbol;

- (NSDate *)getTheEarlyDateFromDidSelectDate:(NSMutableArray *)array;
- (NSDate *)getTheLateDateFromDidSelectDate:(NSMutableArray *)array;


- (NSDate *)getDateWithDateStr:(NSString *)str;//2015-08-19 00:00:00
- (NSInteger)getOffDaysDate:(NSDate *)date OtherDate:(NSDate *)otherDate;//获取2个时间段之间的间隔时间
- (NSInteger)getOffYearDate:(NSDate *)date OtherDate:(NSDate *)otherDate;

@end
