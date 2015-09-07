//
//  ViewController.m
//  core_data
//
//  Created by liujun on 15/9/7.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Card.h"
#import "Persion.h"
#import <CoreData/CoreData.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

//添加和删除只要有manageContentext就行
@property (nonatomic,strong)NSManagedObjectContext *managerContext;

//查看数据需要有一个fetchRequest
@property (nonatomic,strong)NSFetchedResultsController *fetchResultController;

@property (nonatomic,strong)NSArray *dataList;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = @[];
    }
    return _dataList;
}

- (NSManagedObjectContext *)managerContext {
    
    if (!_managerContext) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        _managerContext = delegate.managedObjectContext;
    }
    return _managerContext;
}

- (NSFetchedResultsController *)fetchResultController {
    
    if (!_fetchResultController) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        request.entity = [NSEntityDescription entityForName:@"Persion" inManagedObjectContext:self.managerContext];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
        request.sortDescriptors = @[sort];
        _fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managerContext sectionNameKeyPath:nil cacheName:@"Data"];
        _fetchResultController.delegate = self;
    }
    
    return _fetchResultController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
}

- (void)getData {
    //获取数据
    NSFetchRequest *request = self.fetchResultController.fetchRequest;
    NSError *error = nil;
    NSArray *arr = [self.managerContext executeFetchRequest:request error:&error];
    if (!arr) {
        NSLog(@"获取数据失败%@",error);
    }else  {
        self.dataList = arr;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    Persion *per = self.dataList[indexPath.row];
    cell.textLabel.text = per.name;
    
    return cell;
}

- (IBAction)add:(id)sender {
    Persion *persion = [NSEntityDescription insertNewObjectForEntityForName:@"Persion" inManagedObjectContext:self.managerContext];
    persion.name = @"hahaha";
    NSError *error = nil;
    if (![self.managerContext save:&error]) {
        NSLog(@"%@",error);
    }
    [self getData];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)de:(id)sender {
    
    //获取所有的数据
    NSArray *arr = [self.managerContext executeFetchRequest:self.fetchResultController.fetchRequest error:nil];
    if (arr.count > 0) {
    [self.managerContext deleteObject:arr[0]];
    }
    
    [self getData];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
