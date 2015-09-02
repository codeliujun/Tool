//
//  LIUWeekView.m
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#define kLabelWidth         self.bounds.size.width/7.0
#define kLabelHeight        self.bounds.size.height

#import "LIUWeekView.h"

@interface LIUWeekView ()

@property(nonatomic,strong)NSMutableArray *allWeekLabels;

@end

@implementation LIUWeekView

- (NSMutableArray *)allWeekLabels {
    if (!_allWeekLabels) {
        _allWeekLabels = [NSMutableArray new];
    }
    return _allWeekLabels;
}

- (void)setFirstWeekDay:(FirstWeekDay)firstWeekDay {
    
    NSArray *week = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    firstWeekDay = firstWeekDay-1;
    for (int i = 0; i < 7; i++) {
        //NSLog(@"%d",firstWeekDay);
        UILabel *label = self.allWeekLabels[i];
        label.text = week[firstWeekDay];
        firstWeekDay = (firstWeekDay+1)%7;
    }
    
}

- (instancetype)init {
    if (self = [super init]) {
        [self layoutSubLabels];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self layoutSubLabels];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutSubLabels];
    }
    return self;
}

- (void)layoutSubLabels {
    
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*kLabelWidth, 0, kLabelWidth, kLabelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        //label.backgroundColor = [UIColor yellowColor];
        //label.text = [NSString stringWithFormat:@"星期%d",i];
        [self.allWeekLabels addObject:label];
        [self addSubview:label];
    }
    self.firstWeekDay = FirstWeekDaySUN;
    
}


@end
