//
//  ZHOrderListHeaderView.m
//  ZHTourist
//
//  Created by liujun on 15/8/11.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#define kItemWidth      self.contentView.width/3.0
#define kItemHeight     self.contentView.height/2.0

#import "ZHOrderListHeaderView.h"
#import "ZHMainFunctionView.h"

@interface ZHOrderListHeaderView ()<ZHMainFunctionViewDelegate> {
    
    ZHMainFunctionView  *_appointmentView;
    ZHMainFunctionView  *_willPayView;
    ZHMainFunctionView  *_willPerformedView;
    ZHMainFunctionView  *_performingView;
    ZHMainFunctionView  *_evaluationView;
    ZHMainFunctionView  *_completedView;
}

@property (strong, nonatomic)UIView *contentView;
@property (nonatomic, strong)NSArray *orderLisetViews;

@end

@implementation ZHOrderListHeaderView

- (NSArray *)orderLisetViews {
    if (!_orderLisetViews) {
        [self initFunctionViews];
        _orderLisetViews = @[_appointmentView,_willPayView,_willPerformedView,_performingView,_evaluationView,_completedView];
    }
    return _orderLisetViews;
}

+ (ZHOrderListHeaderView *)view {
    ZHOrderListHeaderView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    return view;
}

- (void)initFunctionViews {
    
    _appointmentView = [ZHMainFunctionView view];
    _appointmentView.delegate = self;
    [_appointmentView setImageViewWithNormalImage:[UIImage imageNamed:@"ao_n"] HighlightImage:[UIImage imageNamed:@"ao_h"]];
    [_appointmentView setLabelStr:@"预约中"];
    [_appointmentView selected];
    
    _willPayView = [ZHMainFunctionView view];
    _willPayView.delegate = self;
    [_willPayView setImageViewWithNormalImage:[UIImage imageNamed:@"pay_n"] HighlightImage:[UIImage imageNamed:@"pay_h"]];
    [_willPayView setLabelStr:@"待支付"];
    [_willPayView unselected];
    
    _willPerformedView = [ZHMainFunctionView view];
    _willPerformedView.delegate = self;
    [_willPerformedView setImageViewWithNormalImage:[UIImage imageNamed:@"will_per_n"] HighlightImage:[UIImage imageNamed:@"will_per_h"]];
    [_willPerformedView setLabelStr:@"待执行"];
    [_willPerformedView unselected];
    
    _performingView = [ZHMainFunctionView view];
    _performingView.delegate = self;
    [_performingView setImageViewWithNormalImage:[UIImage imageNamed:@"ing_n"] HighlightImage:[UIImage imageNamed:@"ing_h"]];
    [_performingView setLabelStr:@"进行中"];
    [_performingView unselected];
    
    _evaluationView = [ZHMainFunctionView view];
    _evaluationView.delegate = self;
    [_evaluationView setImageViewWithNormalImage:[UIImage imageNamed:@"envalu_n"] HighlightImage:[UIImage imageNamed:@"envalu_h"]];
    [_evaluationView setLabelStr:@"待评价"];
    [_evaluationView unselected];
    
    _completedView = [ZHMainFunctionView view];
    _completedView.delegate = self;
    [_completedView setImageViewWithNormalImage:[UIImage imageNamed:@"comple_n"] HighlightImage:[UIImage imageNamed:@"comple_h"]];
    [_completedView setLabelStr:@"已完成"];
    [_completedView unselected];
    
}

- (void)updateContentView {
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(8, 8, self.width-16, self.height-16)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    for (int i = 0; i < self.orderLisetViews.count; i++) {
        
        ZHOrderListHeaderView *view = self.orderLisetViews[i];
        view.frame = CGRectMake((i%3)*kItemWidth, 5+(i/3)*kItemHeight, kItemWidth, kItemHeight);
        [self.contentView addSubview:view];
        
    }
    
}

- (void)functionViewDidSelect:(ZHMainFunctionView *)functionView {
    
    for (ZHMainFunctionView *view in self.orderLisetViews) {
        if (view == functionView) {
            [view selected];
        }else {
            [view unselected];
        }
    }
    
    NSInteger index = [self.orderLisetViews indexOfObject:functionView];
    OrderStatus status = -1;
    /*
     OrderStatusAppointment = 1, //预约中
     OrderStatusWillPay,         //待支付
     OrderStatusWillPerformed,   //待执行
     OrderStatusPerforming,      //进行中
     OrderStatusEvaluation,      //待评价
     OrderStatusCompleted,       //已完成
     */
    switch (index) {
        
        case 0:
            status = OrderStatusAppointment;
            break;
       
        case 1:
            status = OrderStatusWillPay;
            break;
        
        case 2:
            status = OrderStatusWillPerformed;
            break;
        
        case 3:
            status = OrderStatusPerforming;
            break;
        
        case 4:
            status = OrderStatusEvaluation;
            break;
        
        case 5:
            status = OrderStatusCompleted;
            break;
        
        default:
            break;
    }
    
    if (self.orderListDidSelectStatusBlock) {
        self.orderListDidSelectStatusBlock(status);
    }
    
    
}

- (void)setSelectView:(NSInteger)index {
    
    for (int i = 0; i < self.orderLisetViews.count; i++) {
        ZHMainFunctionView *view = self.orderLisetViews[i];
        if (i == index) {
            [view selected];
        }
        else {
            [view unselected];
        }
    }
}

@end
