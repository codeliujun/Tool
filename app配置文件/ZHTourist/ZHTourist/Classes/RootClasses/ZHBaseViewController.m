//
//  ZHBaseViewController.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHBaseViewController.h"
#import "ZHIndicatorView.h"
#import "ZHToastView.h"

@interface ZHBaseViewController () {
    ZHIndicatorView * _indicatorView;    //加载试图
    ZHToastView     * _toastView;      //吐司视图
}

@end

@implementation ZHBaseViewController

- (id)init {
    if (self = [super init]) {
        _indicatorView = [[ZHIndicatorView alloc] init];
        _toastView = [[ZHToastView alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)show{
    [_indicatorView show];
}

- (void)dismiss {
    [_indicatorView dismiss];
}

- (void)showToast:(NSString *)toast{
    _toastView.toast = toast;
    [_toastView showInView:self.view];
}

#pragma mark - UI
- (void)initUI {
    
}

- (void)initBackBtn {
    self.navigationItem.hidesBackButton = YES;
    _leftBtn = (UIButton *)[self.navigationController.navigationBar viewWithTag:leftBtnTag];
    if (nil == _leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = leftBtnTag;
        _leftBtn.frame = CGRectMake(0, 0, 70, 44);
        [_leftBtn setImage:[UIImage imageNamed:@"btn_back_norm"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_back_press"] forState:UIControlStateHighlighted];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.navigationController.navigationBar addSubview:_leftBtn];
    }
    
    __weak UIViewController *weakSelf = self;
    [_leftBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf performSelector:@selector(backAction:) withObject:_leftBtn];
    }];
    
    if (self.navigationController.viewControllers.count > 1) {
        _leftBtn.hidden = NO;
    } else {
        _leftBtn.hidden = YES;
    }
}

- (void)initRightBtn {
    _rightBtn = (UIButton *)[self.navigationController.navigationBar viewWithTag:rightBtnTag];
    if (nil == _rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = rightBtnTag;
        _rightBtn.frame = CGRectMake(250, 0, 70, 44);
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.navigationController.navigationBar addSubview:_rightBtn];
    }
    
    __weak UIViewController *weakSelf = self;
    [_rightBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf performSelector:@selector(rightAction:) withObject:_rightBtn];
    }];
    _rightBtn.hidden = YES;
}

- (void)setRightNavBtnTitle:(NSString *)title {
    _rightBtn.hidden = NO;
    [_rightBtn setImage:nil forState:UIControlStateNormal];
    [_rightBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setRightNavBtnImage:(UIImage *)image {
    _rightBtn.hidden = NO;
    [_rightBtn setTitle:nil forState:UIControlStateNormal];
    [_rightBtn setImage:image forState:UIControlStateNormal];
}

- (void)rightAction:(UIButton *)button {
    
}

- (void)initLogo {
    if (nil == _imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
        _imgLogo.image = [UIImage imageNamed:@"ico_logo"];
        [self.navigationController.navigationBar addSubview:_imgLogo];
    }
    
    _imgLogo.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark- Action

- (void)backAction:(id)sender{
    [self dismiss];
    
    [self back];
}

- (void)back {
    NSLog(@"self.isBackToRoot: %d", self.isBackToRoot);
    if (self.navigationController.viewControllers.count > 0 ) {
        if (!self.isBackToRoot) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - network
- (void)loadData {
    
}

- (void)requestMethod:(NSString *)method parameter:(NSDictionary *)parameters {
    [self show];
    [[ZHRequestManager requestManager] requestMethod:method parameter:parameters successHandler:^(NSDictionary *result) {
        [self dismiss];
        [self requestSuccess:result];
    } errorHandler:^(NSDictionary *errorDic) {
        [self dismiss];
        [self requestError:errorDic];
    }];
}

- (void)requestSuccess:(NSDictionary *)result {
    DBLog(@"request result: %@", result);
}

- (void)requestError:(NSDictionary *)error {
    DBLog(@"request error: %@", error);
    [self showToast:[error objectForKey:@"error"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
