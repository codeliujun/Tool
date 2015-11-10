//
//  ViewController.m
//  TopLeftLabel
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "ViewController.h"
#import "TopLeftLabel.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet TopLeftLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.label.text = textField.text;
    return YES;
}

@end
