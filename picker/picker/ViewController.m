//
//  ViewController.m
//  picker
//
//  Created by liujun on 15/9/6.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (nonatomic,strong)NSDictionary *dataList;

@property (nonatomic,strong)NSArray *dataListKey;

@property (nonatomic,assign)NSInteger currentIndex;//当前选中的第一个分区

@end

@implementation ViewController

- (NSDictionary *)dataList {
    
    if (!_dataList) {
        _dataList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    }
    return _dataList;
    
}

- (NSArray *)dataListKey {
    if (!_dataListKey) {
        _dataListKey = [self.dataList allKeys];
    }
    return _dataListKey;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker.showsSelectionIndicator = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == component) {
        return self.dataListKey.count;
    }
    else {
        
        NSString *key = self.dataListKey[self.currentIndex];
        NSArray *subCity = self.dataList[key];
        
        return subCity.count;
    }
    
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSString *str = @"---";
//    if (0 == component) {
//        str = self.dataListKey[row];
//    }
//    
//    if (1 == component) {
//        
//        NSString *key = self.dataListKey[self.currentIndex];
//        NSArray *subCity = self.dataList[key];
//        str = subCity[row];
//    }
//    
//    return str;
//}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str = @"---";
    if (0 == component) {
        str = self.dataListKey[row];
    }
    
    if (1 == component) {
        
        NSString *key = self.dataListKey[self.currentIndex];
        NSArray *subCity = self.dataList[key];
        str = subCity[row];
    }
    
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9.0f],NSForegroundColorAttributeName:[UIColor greenColor]}];
    
    return attStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == component) {
        self.currentIndex = row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
