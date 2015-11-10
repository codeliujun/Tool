//
//  ZHBaseViewController.h
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHRequestManager.h"

#define leftBtnTag      0x1001
#define rightBtnTag     0x1002

@interface ZHBaseViewController : UIViewController {
    
}

@property(nonatomic, assign) BOOL isBackToRoot; //是否返回到根试图
@property(strong, nonatomic) UIButton *leftBtn;
@property(strong, nonatomic) UIButton *rightBtn;
@property(strong, nonatomic) UIImageView *imgLogo;

- (void)initUI;
//返回
- (void)back;
// navigation 右上角按钮
- (void)rightAction:(UIButton *)button;
- (void)setRightNavBtnTitle:(NSString *)title;
- (void)setRightNavBtnImage:(UIImage *)image;

- (void)show;
- (void)dismiss;
- (void)showToast:(NSString *)toast;

- (void)loadData;
- (void)requestMethod:(NSString *)method parameter:(NSDictionary *)parameters;
- (void)requestSuccess:(NSDictionary *)result;
- (void)requestError:(NSDictionary *)error;


@end
