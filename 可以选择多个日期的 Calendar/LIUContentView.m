//
//  LIUContentView.m
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#define kViewWidth              self.bounds.size.width/7.0
#define kViewHeight             self.bounds.size.height/6.0

#import "LIUContentView.h"
#import "LIUDayView.h"

@interface LIUContentView ()

@property(nonatomic,strong)NSMutableArray *allDateViews;

@end

@implementation LIUContentView

- (NSMutableArray *)allDateViews {
    if (!_allDateViews) {
        _allDateViews = [NSMutableArray new];
    }
    return _allDateViews;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       
        /**
         *  @author 刘俊, 15-07-10
         *
         *  创建42个view
         */
        [self addDateViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addDateViews];
    }
    return self;
}

- (instancetype)init {
    if ((self = [super init])) {
        [self addDateViews];
    }
    return self;
}

- (void)addDateViews {
    
    for (int i = 0; i < 42; i++) {
        LIUDayView *view = [[LIUDayView alloc]initWithFrame:CGRectMake(i%7*kViewWidth, i/7*kViewHeight, kViewWidth, kViewHeight)];
        //view.date = [NSDate new];
        //view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self.allDateViews addObject:view];
        [self addSubview:view];
    }
    
}

- (void)upDateContentWithFirstWeekDay:(NSInteger)firstWeekDay AndMouthDays:(NSInteger)mouthDays AndDates:(NSArray *)dates {
    NSInteger index = firstWeekDay-1;
    for (int i = 0; i < mouthDays; i++) {
        LIUDayView *dayView = self.allDateViews[index];
        NSDate *date = dates[i];
        dayView.date = date;
        index++;
    }
}

- (void)upDateContentWithDates:(NSArray *)dates {
    
    for (int i = 0; i < self.allDateViews.count; i++) {
        LIUDayView *dayView = self.allDateViews[i];
        NSDate *date = dates[i];
        dayView.date = date;
    }
}

@end
