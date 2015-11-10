//
//  TestViewController.m
//  UploadImageDemo
//
//  Created by liujun on 15/10/16.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "TestViewController.h"
#import "backVie.h"

@interface TestViewController ()

@property (nonatomic,strong)backVie *backView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView = [[backVie alloc]init];
    self.backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.backView];
    // Do any additional setup after loading the view.
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
