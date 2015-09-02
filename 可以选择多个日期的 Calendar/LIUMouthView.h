//
//  LIUMouthView.h
//  LIUCalendar
//
//  Created by liujun on 15/7/12.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LIUMouthViewDelegate <NSObject>

- (void)didTapPreviousButton;
- (void)didTapNextButton;

@end


@interface LIUMouthView : UIView

@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,weak)id<LIUMouthViewDelegate> delegate;

@end
