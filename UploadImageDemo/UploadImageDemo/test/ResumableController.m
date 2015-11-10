//
//  ResumableController.m
//  UploadImageDemo
//
//  Created by liujun on 15/10/15.
//  Copyright © 2015年 liujun. All rights reserved.
//

#import "ResumableController.h"
#import "TestViewController.h"

@interface ResumableController ()<NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSData *partialData;
@property (nonatomic,strong)NSURLSession  *currentSession;

@property (strong, nonatomic) NSURLSessionDownloadTask *resumableTask;   // 可恢复的下载任务

@end

@implementation ResumableController

- (NSURLSession *)currentSession {
    
    if (!_currentSession) {
//        NSOperation *op1 = [NSOperation ]
//        NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
        _currentSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return _currentSession;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downLoad:(UIButton *)sender {
    
    //创建下载任务
    if (self.partialData ) {
        return;//证明已经有缓存了
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/image/6@2x.png"]];
//    sender.enabled = NO;
    self.resumableTask = [self.currentSession downloadTaskWithRequest:request];
    NSLog(@"%@",self.currentSession.delegate);
//    self.resumableTask = [self.currentSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",location.absoluteString);
//        self.imageView.image = [UIImage imageWithContentsOfFile:location.absoluteString];
//    }];
    [self.resumableTask resume];
}

- (IBAction)pause:(UIButton *)sender {
    
    [self.resumableTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.partialData = resumeData;
        //在这里不能将session cancle
        self.resumableTask = nil;
    }];
    
}
- (IBAction)start:(UIButton *)sender {
    
    if (!self.partialData) {
        return;
    }
    
    self.resumableTask = [self.currentSession downloadTaskWithResumeData:self.partialData];
    
    [self.resumableTask resume];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat progress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
        
        self.label.text = [NSString stringWithFormat:@"%.2f",progress*100];

    });
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"%@",location.absoluteString);
    NSData *data = [NSData dataWithContentsOfURL:location];
    self.imageView.image = [UIImage imageWithData:data];
    });
}
- (IBAction)push:(id)sender {
    
    TestViewController *tVC = [[TestViewController alloc]init];
    [self.navigationController pushViewController:tVC animated:YES];
    
}

@end
