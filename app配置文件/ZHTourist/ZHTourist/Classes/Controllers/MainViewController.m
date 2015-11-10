//
//  MainViewController.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "MainViewController.h"
#import "ZHBaseNavigationController.h"
#import "ZHLoginController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //判断游客是否登录
    /*
    ZHUserObj *userObj = [ZHConfigObj configObject].userObject;
    if (userObj.token.length == 0) {
        ZHLoginController *controller = [[ZHLoginController alloc] init];
        ZHBaseNavigationController *nav = [[ZHBaseNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
