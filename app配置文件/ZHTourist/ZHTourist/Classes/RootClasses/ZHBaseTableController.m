//
//  ZHBaseTableController.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHBaseTableController.h"

@interface ZHBaseTableController ()

@end

@implementation ZHBaseTableController
@synthesize tableView = _tableView;

- (id)init {
    if (self = [super init]) {
        dataListArray = @[].mutableCopy;
        isRefresh = YES;
        nextPage = 0;
        currentPage = 1;
        canLoadMore = NO;
        isLoading = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (dataListArray.count == 0) {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)refresh {
    isRefresh = YES;
    currentPage = 1;

    [self loadData];
}

- (void)loadMore {
    currentPage = nextPage;
}

- (void)requestSuccess:(NSDictionary *)result {
    NSArray *array = [result objectForKey:@"list"];
    if (array.count > 0) {
        if (isRefresh) {
            isRefresh = NO;
            [dataListArray removeAllObjects];
        }
        
        [dataListArray addObjectsFromArray:array];
    }
    
    [_tableView finishLoadData:YES];
    _tableView.refreshHeaderView.state = EGOPullRefreshNormal;
    [_tableView reloadData];
}

- (void)requestMethod:(NSString *)method parameter:(NSDictionary *)parameters {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setValue:@(currentPage) forKey:@"page"];
    [dic setValue:@(20) forKey:@"page_size"];
    
    [super requestMethod:method parameter:dic];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[BCTableView class]]) {
        BCTableView *table = (BCTableView *)scrollView;
        [table scrollViewDidScroll:table];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[BCTableView class]]) {
        BCTableView *table = (BCTableView *)scrollView;
        [table scrollViewWillBeginDragging:table];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isKindOfClass:[BCTableView class]]) {
        BCTableView *table = (BCTableView *)scrollView;
        [table scrollViewDidEndDragging:table willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[BCTableView class]]) {
        BCTableView *table = (BCTableView *)scrollView;
        [table scrollViewDidEndDecelerating:table];
    }
}

#pragma mark - BCTableViewDelegate functions
- (void)tableView:(BCTableView *)tableView reloadDataWillBegin:(EGORefreshTableHeaderView *)refreshHeaderView
{
    [self refresh];
}

- (BOOL)tableViewLoadMore:(BCTableView *)tableView {
    if (canLoadMore) {
        [self loadMore];
        return YES;
    }
    
    return NO;
}

#pragma mark - table view default Delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

@end
