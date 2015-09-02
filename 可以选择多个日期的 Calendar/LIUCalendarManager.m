//
//  LIUCalendarManager.m
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "LIUCalendarManager.h"
#import "NSDate+date.h"

@interface LIUCalendarManager ()

@property(nonatomic,strong)NSCalendar *myCalendar;

/**
 *  @author 刘俊, 15-07-12
 *
 *  今天的的一些配置
 */
@property(nonatomic,assign)NSInteger todayDay;
@property(nonatomic,assign)NSInteger todayMouth;
@property(nonatomic,assign)NSInteger todayYear;

/**
 *  @author 刘俊, 15-07-12
 *
 *  当前的一些配置
 */
@property(nonatomic,assign)NSInteger currentDay;
@property(nonatomic,assign)NSInteger currentMouth;
@property(nonatomic,assign)NSInteger currentYear;
@property(nonatomic,assign)NSInteger currentMouthDays;

@end

@implementation LIUCalendarManager

- (instancetype)init {
    if (self = [super init]) {
        self.isMultySelect = NO;
    }
    return self;
}

- (NSMutableArray *)didSelectDate {
    if (!_didSelectDate) {
        _didSelectDate = [NSMutableArray new];
    }
    return _didSelectDate;
}

- (NSCalendar *)myCalendar {
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once (&once,^{
#ifdef __IPHONE_8_0
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}

- (void)getTodayInfo {
    NSDateComponents *dc = [self getDeatilInfoWithDate:[NSDate new]];
    self.todayDay = self.currentDay = dc.day;
    self.todayMouth = self.currentMouth = dc.month;
    self.todayYear = self.currentYear = dc.year;
    self.currentMouthDays = [self numberOfDaysInMouthWithDate:[NSDate new]];
}

- (void)reloadData {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectDateNotification:) name:@"LIUCanlendarDidSelectDateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancleSelectDateNotification:) name:@"LIUCanlendarCancleSelectDateNotification" object:nil];
    
    
    
    self.mouthView.delegate = self;
    [self getTodayInfo];
    [self loadContenDate];
}


#pragma --mark 广播
- (void)didSelectDateNotification:(NSNotification *)notification {
    
    if (!self.isMultySelect) {
        [self.didSelectDate removeAllObjects];
    }
    
    //这里数组只管加
    [self.didSelectDate addObject:notification.userInfo[@"date"]];
    
}

- (void)cancleSelectDateNotification:(NSNotification *)notification {
    
    //这里数组只管减 当然考虑代码健壮性还要判断一下的
    [self.didSelectDate removeObject:notification.userInfo[@"date"]];
    
}

/**
 *  @author 刘俊, 15-07-12
 *
 *  指定月份有多少天
 */
- (NSInteger)numberOfDaysInMouthWithDate:(NSDate *)date {
    return [self.myCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

/**
 *  @author 刘俊, 15-07-12
 *
 *  指定日期的详细信息
 */
- (NSDateComponents *)getDeatilInfoWithDate:(NSDate *)date {
    
    return [self.myCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:date];
    
}

/**
 *  @author 刘俊, 15-07-12
 *
 *  计算时间了
 */
- (void)loadContenDate {
    
    NSLog(@"当前月份：%ld月",(long)self.currentMouth);
    
    //获取本月第一天是星期几,本月有多少天
    NSDate *date = [self getDateWithDay:1 Mouth:self.currentMouth Year:self.currentYear];
    NSInteger firstDayWeek = [self getDeatilInfoWithDate:date].weekday;
    self.currentMouthDays = [self numberOfDaysInMouthWithDate:date];
    
    //需要追溯到上个月几天
    NSInteger lastMouthDays = firstDayWeek-1;
    NSMutableArray *marry = [NSMutableArray new];
    
    //上个月
    {
        if (lastMouthDays != 0) {
            NSDictionary *dateInfo = [self getLastMouthWithCurrentMouth:self.currentMouth];
            NSDate *date = [self getDateWithDay:1 Mouth:[dateInfo[@"mouth"] integerValue] Year:[dateInfo[@"year"] integerValue]];
            NSInteger lastMouthAllDays = [self numberOfDaysInMouthWithDate:date];
            for (NSInteger i = lastMouthAllDays-lastMouthDays+1; i <= lastMouthAllDays; i++) {
                NSDate *date = [self getDateWithDay:i Mouth:self.currentMouth-1 Year:self.currentYear];
                date.isOtherMouth = [NSNumber numberWithBool:YES];
                date.isSelect = [NSNumber numberWithBool:NO];
                [marry addObject:date];
            }
        }
        //NSLog(@"last%lu",marry.count);
    }
    
    
    {
        NSInteger day = 1;
        for (int i = 0; i < self.currentMouthDays; i++) {
            
            NSDate *date = [self getDateWithDay:day Mouth:self.currentMouth Year:self.currentYear];
            day++;
            date.isOtherMouth = [NSNumber numberWithBool:NO];
            date.isSelect = [NSNumber numberWithBool:NO];
            
            //在这里加一个判断，该日期是否选择
            for (NSDate *selectDate in self.didSelectDate) {
                if ([self theDate:selectDate isEqualToAnotherDate:date]) {
                    date.isSelect = [NSNumber numberWithBool:YES];
                }
            }
            [marry addObject:date];
        }
        //NSLog(@"current%lu",marry.count);
    }
    
    {
        NSInteger day = 1;
        NSDictionary *dateInfo = [self getNextMouthWithCurrentMouth:self.currentMouth];
        NSDate *date = [self getDateWithDay:1 Mouth:[dateInfo[@"mouth"] integerValue] Year:[dateInfo[@"year"] integerValue]];
        //NSInteger nextMouthAllDays = [self numberOfDaysInMouthWithDate:date];
        for (NSInteger i = lastMouthDays+self.currentMouthDays-1; i < 41; i++) {
            NSDate *date = [self getDateWithDay:day Mouth:self.currentMouth+1 Year:self.currentYear];
            date.isOtherMouth = [NSNumber numberWithBool:YES];
            date.isSelect = [NSNumber numberWithBool:NO];
            day++;
            [marry addObject:date];
        }
    }
    
    //NSLog(@"====%lu",marry.count);
    [self.contentView upDateContentWithDates:marry];
    self.mouthView.dateLabel.text = [NSString stringWithFormat:@"%lu年%.2lu月",self.currentYear,self.currentMouth];
}

/**
 *  @author 刘俊, 15-07-14
 *
 *  判断日期是否相等
 */
- (BOOL)theDate:(NSDate *)date isEqualToAnotherDate:(NSDate *)anotherDate {
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY-MM-dd";
    
    NSString *dateStr = [df stringFromDate:date];
    NSString *anotherDateStr = [df stringFromDate:anotherDate];
    
    return [dateStr isEqualToString:anotherDateStr];
}

/**
 *  @author 刘俊, 15-07-12
 *
 *  返回指定的日期
 */
- (NSDate *)getDateWithDay:(NSInteger)day Mouth:(NSInteger)mouth Year:(NSInteger)year {
    NSDateComponents *dc = [[NSDateComponents alloc]init];
    [dc setDay:day];
    [dc setMonth:mouth];
    [dc setYear:year];
    return [self.myCalendar dateFromComponents:dc];
}


/**
 *  @author 刘俊, 15-07-12
 *
 *  获取上下个月的信息
 */
- (NSDictionary *)getLastMouthWithCurrentMouth:(NSInteger)currentMouth {
    
    NSInteger lastMouth = currentMouth-1;
    NSInteger lastYear = self.currentYear;
    if (lastMouth <= 0) {
        lastMouth = 12;
        lastYear = lastYear-1;
    }
    
    return @{@"year":@(lastYear),@"mouth":@(lastMouth)};
}

- (NSDictionary *)getNextMouthWithCurrentMouth:(NSInteger)currentMouth {
    NSInteger nextMouth = currentMouth+1;
    NSInteger nextYear = self.currentYear;
    if (nextMouth >= 13) {
        nextMouth = 1;
        nextYear = nextYear+1;
    }
    return @{@"year":@(nextYear),@"mouth":@(nextMouth)};
}

- (void)loadPreviousMouth {
    NSDictionary *dateInfo = [self getLastMouthWithCurrentMouth:self.currentMouth];
    self.currentMouth = [dateInfo[@"mouth"] integerValue];
    self.currentYear = [dateInfo[@"year"] integerValue];
    [self loadContenDate];
}

- (void)loadNextMouth {
    NSDictionary *dateInfo = [self getNextMouthWithCurrentMouth:self.currentMouth];
    self.currentMouth = [dateInfo[@"mouth"] integerValue];
    self.currentYear = [dateInfo[@"year"] integerValue];
    [self loadContenDate];
}

/**
 *  @author 刘俊, 15-07-12
 *
 *  MouthViewDelegate
 */
- (void)didTapNextButton {
    [self loadNextMouth];
}

- (void)didTapPreviousButton {
    [self loadPreviousMouth];
}

- (NSString *)getWeekStrWithDate:(NSDate *)date {
    NSDateComponents *dc = [self getDeatilInfoWithDate:date];
    switch (dc.weekday) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)dealloc {
    NSLog(@"dealloc执行了");
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectDateNotification:) name:@"LIUCanlendarDidSelectDateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LIUCanlendarDidSelectDateNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LIUCanlendarCancleSelectDateNotification" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancleSelectDateNotification:) name:@"LIUCanlendarCancleSelectDateNotification" object:nil];
    
    
}

@end
