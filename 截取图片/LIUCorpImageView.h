//
//  LIUCorpImageView.h
//  LIUCutRectImage
//
//  Created by liujun on 15/9/2.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SuccessBlock) (UIImage *image);
@class LIUCropImageMaskView;
@interface LIUCorpImageView : UIView<UIScrollViewDelegate>{
@private
    UIScrollView            *_scrollView;
    UIImageView             *_imageView;
    LIUCropImageMaskView    *_maskView;
    UIImage                 *_image;
    UIEdgeInsets            _imageInset;
    CGSize                  _cropSize;
    SuccessBlock            _successBlock;
    BOOL                    _isCircle;
}

- (void)setImage:(UIImage *)image;

- (void)setCropSize:(CGSize)size IsCircle:(BOOL)isCircle;

- (UIImage *)cropImage;
- (void)showClipSuccess:(SuccessBlock)success;
- (void)dismiss;

@end

@interface LIUCropImageMaskView : UIView {
@private
    CGRect              _cropRect;
    BOOL                _isCircle;
}

- (void)setCropSize:(CGSize)size IsCircle:(BOOL)isCircle;
- (CGSize)cropSize;

@end