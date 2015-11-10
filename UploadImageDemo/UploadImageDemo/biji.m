//
//  biji.m
//  UploadImageDemo
//
//  Created by liujun on 15/10/15.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "biji.h"

@implementation biji


- (void)NSURLSessionConfiguration {
    
    //用NSURLSessionConfiguration来配置Session
    NSURLSessionConfiguration *defaultCon = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSessionConfiguration *ephemeralCon = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSessionConfiguration *backgroundCon = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"back"];
    
    
    /* allow request to route over cellular. */
//    @property BOOL allowsCellularAccess;
    
    /* allows background tasks to be scheduled at the discretion of the system for optimal performance. */
//    @property (getter=isDiscretionary) BOOL discretionary NS_AVAILABLE(10_10, 7_0);
    
    /*
     allowsCellularAccess 属性指定是否允许使用蜂窝连接， discretionary属性为YES时表示当程序在后台运作时由系统自己选择最佳的网络连接配置，该属性可以节省通过蜂窝连接的带宽。在使用后台传输数据的时候，建议使用discretionary属性，而不是allowsCellularAccess属性，因为它会把WiFi和电源可用性考虑在内。补充：这个标志允许系统为分配任务进行性能优化。这意味着只有当设备有足够电量时，设备才通过Wifi进行数据传输。如果电量低，或者只仅有一个蜂窝连接，传输任务是不会运行的。后台传输总是在discretionary模式下运行。
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultCon];
}


- (void)NSURLSession {
    
    /*
     * The shared session uses the currently set global NSURLCache,
     * NSHTTPCookieStorage and NSURLCredentialStorage objects.
     */
// 1.   + (NSURLSession *)sharedSession;
    
    /*
     * Customization of NSURLSession occurs during creation of a new session.
     * If you only need to use the convenience routines with custom
     * configuration options it is not necessary to specify a delegate.
     * If you do specify a delegate, the delegate will be retained until after
     * the delegate has been sent the URLSession:didBecomeInvalidWithError: message.
     */
// 2.   + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
// 3.   + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue;
    /*
     第一种方式是使用静态的sharedSession方法，该类使用共享的会话，该会话使用全局的Cache，Cookie和证书。
     第二种方式是通过sessionWithConfiguration:方法创建对象，也就是创建对应配置的会话，与NSURLSessionConfiguration合作使用。
     
     第三种方式是通过sessionWithConfiguration:delegate:delegateQueue方法创建对象，二三两种方式可以创建一个新会话并定制其会话类型。该方式中指定了session的委托和委托所处的队列。当不再需要连接时，可以调用Session的invalidateAndCancel直接关闭，或者调用finishTasksAndInvalidate等待当前Task结束后关闭。这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。Delegate收到这个事件之后会被解引用。
     */
    
}


@end
