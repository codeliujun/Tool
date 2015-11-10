//
//  AnimationViewController.m
//  TestCellAnimation
//
//  Created by liujun on 15/11/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.label sizeToFit];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)starAnimation:(UIButton *)sender {
    
    
    [self.button.layer addAnimation:[self getCAAnimation] forKey:nil];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.label.text = [textField.text stringByAppendingString:string];
    [self.label sizeToFit];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)print:(UIButton *)sender {
    NSLog(@"点击了我");
}


- (CAAnimationGroup *)getCAAnimation {
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = self.button.center;
    CGPoint willGo = CGPointMake(self.view.bounds.size.width-50, self.view.bounds.size.height-50);
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddQuadCurveToPoint(path, NULL, willGo.x, point.y, willGo.x, willGo.y);
    animation1.path = path;
    
    
    group.animations = @[animation1];
    group.duration = 5;
    group.repeatCount = 999;
    
    return group;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if ([self.button.layer.presentationLayer hitTest:touchPoint]) {
        [self print:self.button];
    }
    
    
    
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
