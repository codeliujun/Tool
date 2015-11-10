//
//  ZHMyInfoController.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHMyInfoController.h"

@interface ZHMyInfoController ()

@end

@implementation ZHMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI {
    [super initUI];
    
    BCTableView *tableView = self.tableView;
    [tableView refreshHeaderEnable:NO];
    [tableView refreshTailEnable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
