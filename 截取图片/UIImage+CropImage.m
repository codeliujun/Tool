//
//  UIImage+CropImage.m
//  LIUCutRectImage
//
//  Created by liujun on 15/9/2.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import "UIImage+CropImage.h"

@implementation UIImage (CropImage)

- (UIImage *)flip:(BOOL)isHorizontal {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    if (isHorizontal) {
        CGContextRotateCTM(ctx, M_PI);
        CGContextTranslateCTM(ctx, -rect.size.width, -rect.size.height);
    }
    CGContextDrawImage(ctx, rect, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)flipVertical {
    return [self flip:NO];
}

- (UIImage *)flipHorizontal {
    return [self flip:YES];
}

- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)clipCircleImageSize:(CGSize)size {
    if (size.height != size.width) {
        size = CGSizeMake(MIN(size.width, size.height), MIN(size.width, size.height));
    }
    
    //打开上下文
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width*0.5, size.height*0.5) radius:size.width*0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path addClip];
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  
    return image;
}

- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

@end
