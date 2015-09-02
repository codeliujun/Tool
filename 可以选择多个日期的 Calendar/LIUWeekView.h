//
//  LIUWeekView.h
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

/**
 *  @author 刘俊, 15-07-10
 *
 *  这个View来控制显示星期几
 */

typedef enum {
    FirstWeekDaySUN = 1,
    FirstWeekDayMON,
    FirstWeekDayTUE,
    FirstWeekDayWED,
    FirstWeekDayTHU,
    FirstWeekDayFRI,
    FirstWeekDaySAT
}FirstWeekDay;

#import <UIKit/UIKit.h>

@interface LIUWeekView : UIView

//后期再去建设
@property(nonatomic,assign,readonly)FirstWeekDay firstWeekDay;

@end
