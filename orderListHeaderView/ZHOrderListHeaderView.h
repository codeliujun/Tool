//
//  ZHOrderListHeaderView.h
//  ZHTourist
//
//  Created by liujun on 15/8/11.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHOrderListHeaderView : UIView

@property (nonatomic, strong)void (^orderListDidSelectStatusBlock) (OrderStatus);

+ (ZHOrderListHeaderView *)view;
- (void)updateContentView;

- (void)setSelectView:(NSInteger)index;

@end
