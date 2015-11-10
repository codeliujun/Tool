//
//  ViewController.m
//  TestCellAnimation
//
//  Created by liujun on 15/11/9.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "ViewController.h"
#import "LIUGetGoodTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) UIView *basketView;

@property (weak, nonatomic) IBOutlet UIImageView *cartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.basketView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-30, self.view.bounds.size.height - 30, 25, 25)];
    self.basketView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.basketView];
    [self.view bringSubviewToFront:self.basketView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LIUGetGoodTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LIUGetGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.willGoView = self.cartView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

@end
