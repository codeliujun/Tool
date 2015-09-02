//
//  LIUDayView.h
//  LIUCalendar
//
//  Created by liujun on 15/7/10.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUDayView : UIView
/**
 *  @author 刘俊, 15-07-10
 *
 *  2个属性
 */
@property(nonatomic,assign,getter=isCanSelect)BOOL canSelect;
@property(nonatomic,assign,getter=isDidSelect)BOOL didSelect;

@property(nonatomic,strong)NSDate *date;

@end
