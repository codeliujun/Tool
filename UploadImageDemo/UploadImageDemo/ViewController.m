//
//  ViewController.m
//  UploadImageDemo
//
//  Created by liujun on 15/10/15.
//  Copyright © 2015年 liujun. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "ViewController.h"

@interface ViewController ()

//@property (nonatomic,strong)NSURLSessionUploadTask *task;

@property (nonatomic,strong)NSURLSessionDataTask *task;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (copy,nonatomic)NSString *content;
- (IBAction)ChangeContent:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation ViewController


- (void)setContent:(NSString *)content {
    
    if (content) {
        _content = content;
        self.contentLabel.text = _content;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentLabel.text = self.content;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString *)getImageStr {
    
   return [[NSBundle mainBundle] pathForResource:@"登陆页" ofType:@"jpg"];

}

- (IBAction)upLoad:(UIButton *)sender {
    
    [self upLoadImage];
//    [self post];
}

- (void)post {
    
    NSString *url = @"http://127.0.0.1/index.php";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    NSString *bodyStr = @"act=logo";
    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@=====%@====%@===",str,response,error);
    }];
    [task resume];
    
}

- (void)upLoadImage {
    
    WS(ws);
    
    NSString *urlStr = @"http://218.17.122.211:8080/index.php/Home/Upload/index";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:0 timeoutInterval:5.0f];//创建请求
    
    [self setRequest:request WithImage:[UIImage imageNamed:@"2"]];
//    [self appendRequest:request];
//    request.HTTPMethod = @"POST";
//    UIImage *image = [UIImage imageNamed:[self getImageStr]];
//    NSData *data = UIImageJPEGRepresentation(image ,1);
//    request.HTTPBody = data;
    
    self.task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@\n",str);
        NSLog(@"%@=====%@====%@===",str,response,error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = str;
        });

    }];
    NSLog(@"%@",request.URL.absoluteString);
    [self.webView loadRequest:request];
    [self.task resume];
}

- (void)setRequestTest:(NSMutableURLRequest *)request {
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"hahahha" dataUsingEncoding:NSUTF8StringEncoding];
    
}

/*
 --Boundary+72D4CD655314C423   // 分割符，以“--”开头，后面的字随便写，只要不写中文即可
 Content-Disposition: form-data; name="uploadFile"; filename="001.png"  // 这里注明服务器接收图片的参数（类似于接收用户名的userName）及服务器上保存图片的文件名
 Content-Type:image/png  // 图片类型为png
 Content-Transfer-Encoding: binary  // 编码方式
 // 这里是空一行，必不可少！！
 ... contents of boris.png ...  // 图片数据部分
 --Boundary+72D4CD655314C423--  // 分隔符后面以"--"结尾，表明结束
 */

- (void)setRequest:(NSMutableURLRequest *)request WithImage:(UIImage *)image {
    
    NSString *boundary = [NSString stringWithFormat:@"liu%d%d",arc4random(),arc4random()];
    
    //图片数据
    NSMutableString *topStr = [NSMutableString string];
    //NSMutableString *bodyStr = [NSMutableString string];
    NSMutableData *body = [NSMutableData data];
    
    NSString *path = [self getImageStr];
//    NSData *data = [NSData dataWithContentsOfFile:path];//图片数据
//    UIImage *image = [UIImage imageNamed:@"2"];
    NSData *data = UIImageJPEGRepresentation(image ,1);
    
    /**拼装成格式：
     --Boundary+72D4CD655314C423
     Content-Disposition: form-data; name="uploadFile"; filename="001.png"
     Content-Type:image/png
     Content-Transfer-Encoding: binary
     
     ... contents of boris.png ...
     */
    
    //头部
    [topStr appendString:[NSString stringWithFormat:@"--%@\r\n",boundary]];
    [topStr appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",[self getImageStr].lastPathComponent]];
    [topStr appendString:[NSString stringWithFormat:@"Content-Type:image/jpeg\r\n"]];
    [topStr appendString:[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\r\n\r\n"]];
    
    //内容
    [body appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //结束部分
    NSString *bottomStr = [NSString stringWithFormat:@"--%@--",boundary];
    
    [body appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = body;
    
    
    // 设置头部数据，指定了http post请求的编码方式为multipart/form-data（上传文件必须用这个）。
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",[[NSString alloc]initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    //[request setValue:[NSString stringWithFormat:@"%d", 1024] forHTTPHeaderField:@"Content-Length"];
}


- (void)appendRequest:(NSMutableURLRequest *)request {
    
    //分界符号
    NSString *SlipLine = [NSString stringWithFormat:@"fenjie%d%d",arc4random(),arc4random()];
    NSString *topLine = [NSString stringWithFormat:@"--%@",SlipLine];
    NSString *endLine = [NSString stringWithFormat:@"%@--",SlipLine];
    
    //选择要上传的图片
    UIImage *image = [UIImage imageWithContentsOfFile:[self getImageStr]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    imageView.image = image;
    [self.view addSubview:imageView];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    
    //拼接字符串
    //1.添加分界线
    NSMutableString *bodyStr = [NSMutableString string];
    [bodyStr appendFormat:@"%@/r/n",topLine];
    
    //2.声明类型
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"123\"; filename=\"登录页.jpg\"\r\n"];
    
    //3.声明上传文件的格式
    [bodyStr appendFormat:@"Content-Type: image/jpeg\r\n"];
    [bodyStr appendString:[NSString stringWithFormat:@"Content-Transfer-Encoding: binary\r\n"]];
    //4.申明结束符号
    NSString *end = [NSString stringWithFormat:@"\r\n%@",endLine];
    
    NSMutableData *requestData = [NSMutableData data];
    [requestData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [requestData appendData:imageData];
    [requestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // 设置头部数据，指定了http post请求的编码方式为multipart/form-data（上传文件必须用这个）。
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",SlipLine] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    [request setHTTPMethod:@"POST"];
    NSLog(@"%@",[[NSString alloc]initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChangeContent:(UIButton *)sender {
    
    
    self.content = [NSString stringWithFormat:@"%d%d",arc4random(),arc4random()];
    
}
@end
