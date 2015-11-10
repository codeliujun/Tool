//
//  ZHOrderListController.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHOrderListController.h"

@interface ZHOrderListController () {
    
}

@end

@implementation ZHOrderListController

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - network
- (void)loadData {
    [self requestMethod:@"Order/pProgress" parameter:nil];
}

- (void)requestSuccess:(NSDictionary *)result {
    [super requestSuccess:result];
}

#pragma mark - UITableView delegate and dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dic = [dataListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"apply_number"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
