//
//  LIUGetGoodTableViewCell.m
//  TestCellAnimation
//
//  Created by liujun on 15/11/10.
//  Copyright © 2015年 liujun. All rights reserved.
//

#define kScreenSize     [UIScreen mainScreen].bounds.size

#import "LIUGetGoodTableViewCell.h"
#import "LIUCircleLayer.h"
#import "LIUQueueStruct.h"

@interface LIUGetGoodTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UIImageView *reduceImage;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic,assign) NSUInteger count;
@property (nonatomic,strong) LIUQueueStruct *queue;

@end

@implementation LIUGetGoodTableViewCell

- (LIUQueueStruct *)queue {
    if (!_queue) {
        _queue = [LIUQueueStruct new];
    }
    return _queue;
}

- (void)awakeFromNib {
    [self reLayoutSub];
}

- (void)setCount:(NSUInteger)count {
    
    _count = count;
    if (count == 0 || count == 1) {
        [self reLayoutSub];
    }
    [self updateCountLabel];
}

- (void)updateCountLabel {
    self.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)reduce:(UIButton *)sender {
    
    if (self.count > 0) {
        self.count--;
    }else {
        return;
    }
}

- (void)reLayoutSub {
    
    if (self.count == 0) {
        self.reduceButton.enabled = NO;
        self.reduceImage.hidden = YES;
        self.countLabel.hidden = YES;
    }else {
        self.reduceButton.enabled = YES;
        self.reduceImage.hidden = NO;
        self.countLabel.hidden = NO;
    }
}

- (IBAction)add:(UIButton *)sender {
    
    self.count++;
    [self reLayoutSub];
    [self starAnimation];
}

- (void)starAnimation {
    //获取cell的tableview
    UITableView *tableView = (UITableView *)self.superview.superview;
    CGRect addFrame = self.addImage.frame;
    CGPoint layerPoint = CGPointMake(self.frame.origin.x+addFrame.origin.x, self.frame.origin.y-tableView.contentOffset.y+addFrame.origin.y+20);
    //获取需要创建的layer的frame
    CGRect layerFrame = CGRectMake(layerPoint.x, layerPoint.y, addFrame.size.width, addFrame.size.height);
    LIUCircleLayer *layer = [LIUCircleLayer layoutWithFrame:layerFrame];
    [self.willGoView.superview.layer insertSublayer:layer above:tableView.layer];
   
    //创建一个队列结构来存储创建的layer，以便结束之后移除
    [self.queue addValue:layer];
    
    [layer addAnimation:[self getAnimationWithStartPoint:CGPointMake(CGRectGetMidX(layerFrame), CGRectGetMidY(layer.frame))] forKey:nil];
}

- (CAAnimationGroup *)getAnimationWithStartPoint:(CGPoint)startPoint {
    
    CGPoint endPoint = CGPointMake(self.willGoView.center.x, self.willGoView.center.y);    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, NULL, endPoint.x, startPoint.y, endPoint.x, endPoint.y);
    
    animation1.path = path;
    
    
    group.animations = @[animation1];
    group.duration = 0.7;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return group;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {//已经完成
        LIUCircleLayer *layer = [self.queue getValue];
        [layer removeFromSuperlayer];
    }
    
}

@end
