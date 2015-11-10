//
//  BCLoginController.m
//  BookingCar
//
//  Created by Michael Shan on 14-10-3.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "ZHLoginController.h"
#import "BCAddAddressCell.h"
#import "ZHButton.h"

#define kForgetPwdHighlightColor             kColorHexString(@"#0078ff")

@interface ZHLoginController () <UITextFieldDelegate> {
    BCAddAddressCell *_phoneCell;
    BCAddAddressCell *_pwdCell;
    
    NSString *phoneNo;
    NSString *passwordStr;
}

@end

@implementation ZHLoginController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"登录";

    self.leftBtn.hidden = NO;
}

- (void)back {
    if (self.navigationController.viewControllers.count > 1) {
        if (self.isBackToRoot) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)initUI {
    
    BCTableView *_tableView = self.tableView;
    _tableView.backgroundColor = kGroupedTableBackgroundColor;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _tableView.layoutMargins = UIEdgeInsetsZero;
    }
    _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    _tableView.delaysContentTouches = NO;
    _tableView.scrollEnabled = NO;
    _tableView.sectionHeaderHeight = 10;
    _tableView.sectionFooterHeight = 0;

    _phoneCell = [BCAddAddressCell cell];
    [_phoneCell setImgcellImage:[UIImage imageNamed:@"ico_my"]];
    _phoneCell.tfInputField.placeholder = @"请输入您的号码";
    _phoneCell.tfInputField.delegate = self;
    _phoneCell.tfInputField.returnKeyType = UIReturnKeyNext;
    _phoneCell.tfInputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _pwdCell = [BCAddAddressCell cell];
    [_pwdCell setImgcellImage:[UIImage imageNamed:@"ico_my_pwd"]];
    _pwdCell.tfInputField.placeholder = @"请输入您的密码";
    _pwdCell.tfInputField.delegate = self;
    _pwdCell.tfInputField.returnKeyType = UIReturnKeyGo;
    [_pwdCell.tfInputField setSecureTextEntry:YES];
}

- (void)cancelKeyboard {
    phoneNo = _phoneCell.tfInputField.text;
    passwordStr = _pwdCell.tfInputField.text;
    
    [_phoneCell.tfInputField resignFirstResponder];
    [_pwdCell.tfInputField resignFirstResponder];
}

- (void)submitAction:(UIButton *)button {
    [self cancelKeyboard];
    
    if (NO == [phoneNo validatePhone]) {
        [self showToast:@"请输入手机号"];
        return;
    }
    if (passwordStr.length == 0) {
        [self showToast:@"请输入密码"];
        return;
    }
    
    [self login];
}

#pragma mark -
#pragma mark - network request
- (void)login {
    NSDictionary *parameter = @{@"phone":phoneNo, @"pwd":passwordStr};
    [self requestMethod:@"User/login" parameter:parameter];
}

- (void)requestSuccess:(NSDictionary *)result {
    ZHUserObj *userObj = [ZHConfigObj configObject].userObject;
    userObj.token = [result objectForKey:@"token"];
    userObj.phone = [[result objectForKey:@"data"] objectForKey:@"phone"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    
    //提交按钮
    ZHButton *loginBtn = [[ZHButton alloc] initWithFrame:
                  CGRectMake(10, 20, kScreenWidth-20, 45)
                                           title:@"登录"
                                          target:self
                                          action:@selector(submitAction:)
                                            gray:NO];
    [view addSubview:loginBtn];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(10, 75, 150, 20);
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:kForgetPwdHighlightColor forState:UIControlStateHighlighted];
    [forgetPwdBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
//        BCForgetPwdController *controller = [[BCForgetPwdController alloc] initWithType:PhoneControllerResetPwd];
//        [self.navigationController pushViewController:controller animated:YES];
    }];
    [view addSubview:forgetPwdBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(230, 75, 80, 20);
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kNavigationBarColor forState:UIControlStateNormal];
    [registerBtn setTitleColor:kForgetPwdHighlightColor forState:UIControlStateHighlighted];
    [registerBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
//        BCForgetPwdController *controller = [[BCForgetPwdController alloc] initWithType:PhoneControllerRegister];
//        [self.navigationController pushViewController:controller animated:YES];
    }];
    [view addSubview:registerBtn];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (0 == indexPath.row) {
        cell = _phoneCell;
    } else if (1 == indexPath.row) {
        cell = _pwdCell;
    }
    
    if (nil == cell) {
        cell = [BCAddAddressCell cell];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }

    return cell;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //按下键盘右下角的return的操作
    if (textField == _phoneCell.tfInputField) {
        [_pwdCell.tfInputField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self submitAction:nil];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 输入的时候，如果长度大于一定范围，就不再加了
    if (string.length > 0) {
        if (_phoneCell.tfInputField == textField) {
            if (textField.text.length >= 11) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
