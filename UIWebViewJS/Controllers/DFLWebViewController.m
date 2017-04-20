//
//  DFLWebViewController.m
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/19.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLWebViewController.h"
#import "DFLProgressLayer.h"
@interface DFLWebViewController ()<UIWebViewDelegate,DFLWebViewDelegate>
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) DFLProgressLayer *progressLayer;

@end

@implementation DFLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"webViewJS";
    self.view.backgroundColor = [UIColor whiteColor];
    self.progressLayer = [[DFLProgressLayer alloc] initWithFrame:CGRectMake(0, 42, self.view.frame.size.width, 2)];
    self.progressLayer.progressColor = [UIColor redColor];

    [self.navigationController.navigationBar.layer addSublayer:self.progressLayer];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JS.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressLayer startLoadProgressLayer];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressLayer finishedLoadProgressLayer];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //要实现html中以hiant.JSON:()方法必须关联self.context[@"hiant"] = self;实现DFLWebViewDelegate方法
    // hiant.JSOCNOPramas()
    self.context[@"hiant"] = self;
    //执行js不同方法，如js里面的test('helloWorld')；
    self.context[@"hiant_open"] = ^(NSString *string,BOOL isTure) {
        NSLog(@"%@.....%@",string,@(isTure));
    };
    
    //执行js不同方法，如js里面的test('helloWorld')；
    self.context[@"test"] = ^(NSString *string) {
        NSLog(@"%@",string);
        
    };
    
}

////点击html中的链接会重载此方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
    //通过absoluteString可获取链接的url进行业务处理
    NSString *absoluteString = [request URL].absoluteString;
    if ([absoluteString rangeOfString:@"http://www.hianto2o.com"].location != NSNotFound) {
        //页面跳转等不可以在此方法中用webView加载url
        return NO; //不加载web页面
    }
    return YES; //加载web页面
}


/**
  DFLWebViewDelegate
 */
- (void)JSOC:(NSDictionary *)dic {
    
    JSValue *value = self.context[@"OCCallJS"];
    NSLog(@"dic:%@\nvalue:%@",dic,value);
    //执行js方法
    [self.context[@"OCCallJS"] callWithArguments:@[@"杭州欢迎你"]];
}

- (void)JSOCNOPramas {
    NSLog(@"没有参数");
}

@end
