//
//  ZHRequestManager.h
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kServerIP       @"http://218.17.122.211:8080"
#define kApiUrl                 [NSString stringWithFormat:@"%@/Api", kServerIP]
#define kGetRequestUrl(method)  [NSString stringWithFormat:@"%@/%@", kApiUrl, method]
#define kGetImageUrl(relativePath)    [NSString stringWithFormat:@"%@%@", kServerIP, relativePath]

typedef void (^ResultBlock)(NSDictionary *result);
typedef void (^ImageLoadBlock)(UIImage *image);

@interface ZHRequestManager : NSObject

+ (instancetype)requestManager;

/**
 *  @brief 网络请求
 *  @param type 请求类型
 *  @param parameters 请求参数
 *  @param successHandler 成功获取的处理方法
 *  @param errorHandler 获取失败的处理方法
 */
- (void)requestMethod:(NSString *)method parameter:(NSDictionary *)parameters successHandler:(ResultBlock)successBlock errorHandler:(ResultBlock)errorBlock;

/**
 *  @brief 获取图片
 *  @param url 图片url
 *  @param resultHandler 结果处理
 */
- (void)getImageWithUrl:(NSString *)url resultHandler:(ImageLoadBlock)block;

@end
