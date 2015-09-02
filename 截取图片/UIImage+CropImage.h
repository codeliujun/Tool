//
//  UIImage+CropImage.h
//  LIUCutRectImage
//
//  Created by liujun on 15/9/2.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CropImage)

/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*切圆形图*/
- (UIImage *)clipCircleImageSize:(CGSize)size;

/*裁切*/
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@end
