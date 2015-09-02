//
//  ZHMainFunctionView.m
//  ZHTourist
//
//  Created by liujun on 15/8/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHMainFunctionView.h"

@interface ZHMainFunctionView ()


@end

@implementation ZHMainFunctionView

+ (ZHMainFunctionView *)view {
    ZHMainFunctionView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    [view.button addObserver:view forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    return view;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"highlighted"]) {
        if ([change[@"new"] integerValue] == 1) {
            self.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        }else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    
}

- (void)setImageViewWithNormalImage:(UIImage *)normalImage HighlightImage:(UIImage *)highlightImage {
    self.imageView.image = normalImage;
    self.imageView.highlightedImage = highlightImage;
}
- (void)setLabelStr:(NSString *)str {
    self.label.text = str;
}

- (void)unselected {
    self.imageView.highlighted = NO;
    self.label.textColor = [UIColor lightGrayColor];
}

- (void)selected {
    self.imageView.highlighted = YES;
    self.label.textColor = [UIColor blackColor];
}

- (IBAction)statuDidTap:(UIButton *)sender {
    [self.delegate functionViewDidSelect:self];
}


@end
