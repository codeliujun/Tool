//
//  ZHMainFunctionView.h
//  ZHTourist
//
//  Created by liujun on 15/8/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHMainFunctionView;

@protocol ZHMainFunctionViewDelegate <NSObject>

- (void)functionViewDidSelect:(ZHMainFunctionView *)functionView;

@end

@interface ZHMainFunctionView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) id<ZHMainFunctionViewDelegate> delegate;

+ (ZHMainFunctionView *)view;

- (void)setImageViewWithNormalImage:(UIImage *)normalImage HighlightImage:(UIImage *)highlightImage;
- (void)setLabelStr:(NSString *)str;

- (void)unselected;
- (void)selected;

@end
