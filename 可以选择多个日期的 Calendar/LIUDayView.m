//
//  LIUDayView.m
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#define kDateLabelSize          MIN(self.frame.size.width, self.frame.size.height)*4/5.0

#import "LIUDayView.h"
#import "NSDate+date.h"

@interface LIUDayView ()

@property(nonatomic,strong)UILabel *dateLabel;

@end

@implementation LIUDayView

- (void)setDate:(NSDate *)date {
    _date = date;
    [self updateLabel];
}

- (void)updateLabel {
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"dd";
    self.dateLabel.text = [df stringFromDate:self.date];
    
    if ([self.date.isOtherMouth boolValue] == YES) {
        self.canSelect = NO;
        self.didSelect = NO;
        [self isOtheMouth];
    }else {
        //这个里面的肯定就是本月的
        if ([self theDate:self.date isEqualToAnotherDate:[NSDate new]]) {
            self.canSelect = NO;
            self.didSelect = NO;
            [self todayDate];
        }
        else if ([self theDate:self.date isEqualToAnotherDate:[self.date earlierDate:[NSDate new]]]) {
            //返回的最早日期等于本日期，那么就是比今天早
            self.canSelect = NO;
            self.didSelect = NO;
            [self canNotSelect];
        }
        else {
            if ([self.date.isSelect boolValue]==YES) {
                self.canSelect = YES;
                self.didSelect = YES;
                [self didSelect];
            }
            else{
                self.canSelect = YES;
                self.didSelect = NO;
                [self canSelect];
            }
        }
    }
}

- (BOOL)theDate:(NSDate *)date isEqualToAnotherDate:(NSDate *)anotherDate {
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY-MM-dd";
    
    NSString *dateStr = [df stringFromDate:date];
    NSString *anotherDateStr = [df stringFromDate:anotherDate];
    
    return [dateStr isEqualToString:anotherDateStr];
}

/**
 *  @author 刘俊, 15-07-14
 *  今天的日期
 */
- (void)todayDate {
    self.dateLabel.backgroundColor = [UIColor redColor];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.dateLabel.alpha = 1;
    
}

/**
 *  @author 刘俊, 15-07-10
 *
 *  已经被选择
 */
- (void)didSelect {
    self.dateLabel.backgroundColor = kThemeColor;
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.layer.borderColor = kThemeColor.CGColor;
    self.dateLabel.alpha = 1;
    NSLog(@"%@",self.date);
}

/**
 *  @author 刘俊, 15-07-10
 *可以选择
 */
- (void)canSelect {
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.layer.borderColor = kThemeColor.CGColor;
    self.dateLabel.alpha = 1;
}

/**
 *  @author 刘俊, 15-07-10
 *
 *  不能选择
 */
- (void)canNotSelect {
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textColor = kGrayTextColor;
    self.dateLabel.layer.borderColor = [UIColor clearColor].CGColor;
    self.dateLabel.alpha = 1;
}

/**
 *  @author 刘俊, 15-08-07
 *
 *  别的月份的日期
 */
- (void)isOtheMouth {
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textColor = [UIColor lightGrayColor];
    self.dateLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.dateLabel.alpha = 0.0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addLabel];
        //添加手势
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelect:)];
        [self addGestureRecognizer:tapGr];
    }
    return self;
}

- (void)addLabel {
    self.dateLabel = [[UILabel alloc]initWithFrame:
                      CGRectMake(0, 0,kDateLabelSize, kDateLabelSize)];
    self.dateLabel.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    self.dateLabel.layer.cornerRadius = kDateLabelSize*0.5;
    self.dateLabel.layer.masksToBounds = YES;
    self.dateLabel.layer.borderWidth = 1.0;
    //self.dateLabel.layer.borderColor = [UIColor greenColor].CGColor;
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateLabel];
}

/**
 *  @author 刘俊, 15-07-10
 *
 *  Tap手势
 */
- (void)didSelect:(UITapGestureRecognizer *)tapGr {
    
    //NSLog(@"%@",self);
    if (!self.canSelect) {
        return;
    }
    if (self.didSelect) {
        self.didSelect = NO;
        [self canSelect];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LIUCanlendarCancleSelectDateNotification" object:nil userInfo:@{@"date":self.date}];
    }else{
        self.didSelect = YES;
        [self didSelect];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LIUCanlendarDidSelectDateNotification" object:nil userInfo:@{@"date":self.date}];
    }
}

@end
