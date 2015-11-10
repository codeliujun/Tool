//
//  ZHBaseTableController.h
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHBaseViewController.h"
#import "BCTableView.h"

@interface ZHBaseTableController : ZHBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *dataListArray;

    NSInteger currentPage;
    NSInteger nextPage;
    BOOL isRefresh;
    BOOL canLoadMore;
    BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet BCTableView *tableView;

- (void)loadMore;
- (void)refresh;

@end
