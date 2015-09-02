//
//  LIUCorpImageView.m
//  LIUCutRectImage
//
//  Created by liujun on 15/9/2.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "LIUCorpImageView.h"
#import "UIImage+CropImage.h"

@implementation LIUCorpImageView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self scrollView] setFrame:self.bounds];
    [self addButton];
    [[self maskView] setFrame:self.bounds];
    
    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        [self setCropSize:CGSizeMake(100, 100) IsCircle:NO];
    }
}

- (void)addButton {
    
    //1.先添加一个view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5,60, 40)];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancleButton];
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-10-60,5,60, 40)];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:confirmButton];
    
    [self addSubview:view];
    [self bringSubviewToFront:view];
}

#pragma button
- (void)cancle:(UIButton *)sender {
    [self dismiss];
}

- (void)confirm:(UIButton *)sender {
    
    UIImage *image = [self cropImage];
    if (image) {
        if (_successBlock) {
            _successBlock(image);
            [self dismiss];
        }
    }
    
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        //[_scrollView setBounces:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [[self scrollView] addSubview:_imageView];
    }
    return _imageView;
}

- (LIUCropImageMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[LIUCropImageMaskView alloc] init];
        [_maskView setBackgroundColor:[UIColor clearColor]];
        [_maskView setUserInteractionEnabled:NO];
        [self addSubview:_maskView];
        [self bringSubviewToFront:_maskView];
    }
    return _maskView;
}

- (void)setImage:(UIImage *)image {
    if (image != _image) {
        _image = nil;
        _image = image;
    }
    [[self imageView] setImage:_image];
    
    [self updateZoomScale];
}


/**
 *  @author 刘俊, 15-09-02
 *
 *  配置缩小的最小值
 */
- (void)updateZoomScale {
    CGFloat width = _image.size.width;
    CGFloat height = _image.size.height;
#warning 关于frame有疑问
    [[self imageView] setFrame:CGRectMake(0, 0, width, height)];
    
    CGFloat xScale = _cropSize.width / width;
    CGFloat yScale = _cropSize.height / height;
    
    CGFloat min = MAX(xScale, yScale);
    CGFloat max = 1.0;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        max = 1.0 / [[UIScreen mainScreen] scale];
    }
    
    if (min > max) {
        min = max;
    }
    
    [[self scrollView] setMinimumZoomScale:min];
    [[self scrollView] setMaximumZoomScale:max + 5.0f];
    
    [[self scrollView] setZoomScale:max animated:YES];
}

/**
 *  @author 刘俊, 15-09-02
 *
 *  这里的方法我改了
 */
- (void)setCropSize:(CGSize)size IsCircle:(BOOL)isCircle{
    _isCircle = isCircle;
    if (_isCircle) {
        _cropSize = CGSizeMake(MIN(size.width, size.height), MIN(size.width, size.height));
    }else {
        _cropSize = size;
    }
    [self updateZoomScale];
    
    CGFloat width = _cropSize.width;
    CGFloat height = _cropSize.height;
    
    CGFloat x = (CGRectGetWidth(self.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - height) / 2;
    
    
    [_maskView setCropSize:_cropSize IsCircle:isCircle];
    
    CGFloat top = y;
    CGFloat left = x;
    CGFloat right = CGRectGetWidth(self.bounds)- width - x;
    CGFloat bottom = CGRectGetHeight(self.bounds)- height - y;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    [[self scrollView] setContentInset:_imageInset];
    
    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}

- (UIImage *)cropImage {
    CGFloat zoomScale = [self scrollView].zoomScale;
    
    CGFloat offsetX = [self scrollView].contentOffset.x;
    CGFloat offsetY = [self scrollView].contentOffset.y;
    CGFloat aX = offsetX>=0 ? offsetX+_imageInset.left : (_imageInset.left - ABS(offsetX));
    CGFloat aY = offsetY>=0 ? offsetY+_imageInset.top : (_imageInset.top - ABS(offsetY));
    
    aX = aX / zoomScale;
    aY = aY / zoomScale;
    
    CGFloat aWidth =  MAX(_cropSize.width / zoomScale, _cropSize.width);
    CGFloat aHeight = MAX(_cropSize.height / zoomScale, _cropSize.height);
    
#ifdef DEBUG
    NSLog(@"%f--%f--%f--%f", aX, aY, aWidth, aHeight);
#endif
    
    UIImage *image = [_image cropImageWithX:aX y:aY width:aWidth height:aHeight];
    if (_isCircle) {
        image = [image clipCircleImageSize:_cropSize];
    }else {
        image = [image resizeToWidth:_cropSize.width height:_cropSize.height];
    }
    return image;
}

- (void)showClipSuccess:(SuccessBlock)success{
    if (success) {
        _successBlock = success;
    }
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    [window bringSubviewToFront:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self imageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@=====scale:%f",NSStringFromCGPoint(scrollView.contentOffset),[scrollView zoomScale]);
}

@end


#pragma KISnipImageMaskView

#define kMaskViewBorderWidth 2.0f

@implementation LIUCropImageMaskView

/**
 *  @author 刘俊, 15-09-02
 *
 *  这里的方法重写了
 */
- (void)setCropSize:(CGSize)size IsCircle:(BOOL)isCircle{
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    _isCircle = isCircle;
    [self setNeedsDisplay];
}

- (CGSize)cropSize {
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(ctx, 1, 1, 1, .6);
//    CGContextFillRect(ctx, self.bounds);
//    
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
//    
//    //    CGContextSetRGBFillColor(ctx, 1, 1, 1, .0);
//    //    CGContextFillRect(ctx, _cropRect);
//    
//    CGContextClearRect(ctx, _cropRect);
//    
//    //CGContextMoveToPoint(ctx, 100, 100);
//    CGContextAddArc(ctx, 90, 80, 50, 0, 2*M_PI, 1);
//    //CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
//    CGContextSetBlendMode(ctx, kCGBlendModeClear);
//    CGContextFillPath(ctx);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, .6);//填充黑色
    CGContextFillRect(ctx, self.bounds);//填充背景色
    
    if (_isCircle) {
        CGPoint point = CGPointMake(_cropRect.origin.x+(_cropRect.size.width*0.5), _cropRect.origin.y+(_cropRect.size.height*0.5));
        CGContextAddArc(ctx, point.x, point.y, _cropRect.size.width*0.5, 0, 2*M_PI, 1);
        CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
        CGContextSetLineWidth(ctx, 1.0f);//设置线宽
        CGContextStrokePath(ctx);
        CGContextAddArc(ctx, point.x, point.y, _cropRect.size.width*0.5, 0, 2*M_PI, 1);
        CGContextSetBlendMode(ctx, kCGBlendModeClear);//混合模式为透明
        CGContextFillPath(ctx);
    }else {
        CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
        CGContextSetLineWidth(ctx, 1.0f);//设置线宽
        CGContextStrokeRect(ctx, _cropRect);//填充边框
        CGContextAddRect(ctx, _cropRect);
        CGContextSetBlendMode(ctx, kCGBlendModeClear);//混合模式为透明
        CGContextFillPath(ctx);
    }
    
    
    
}
@end
