//
//  DFLWKWebViewController.m
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/19.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface DFLWKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DFLWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"WKWebViewJS";
    self.view.backgroundColor = [UIColor whiteColor];
    if (NSClassFromString(@"WKWebView")) {
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        webViewConfiguration.preferences.minimumFontSize = 16;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:webViewConfiguration];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        self.webView = webView;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKJS" withExtension:@"html"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self.view addSubview:webView];
        WKUserContentController *userCC = webViewConfiguration.userContentController;
        [userCC addScriptMessageHandler:self name:@"test"];
        [userCC addScriptMessageHandler:self name:@"clickButton1"];
        [userCC addScriptMessageHandler:self name:@"clickButton2"];
    }
}


/**WKScriptMessageHandler*/
//window.webkit.messageHandlers.<name>.postMessage(<messageBody>)来调用发送数据给iOS端  postMessage没有参数必须传null或''
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //通过判断让js调用那个方法
    if ([message.name isEqualToString:@"test"]) {
        NSLog(@"no pramas");
    } else if ([message.name isEqualToString:@"clickButton1"]) {
        NSLog(@"one pramas ");
    } else if ([message.name isEqualToString:@"clickButton2"]) {
        NSLog(@"more pramas");
    }
}



/**WKNavigationDelegate*/

//页面重载，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *absoluteString = [navigationAction.request URL].absoluteString;
    NSLog(@"%@",absoluteString);
    if ([absoluteString rangeOfString:@"hiant"].location != NSNotFound) {
       //页面跳转
        [self.navigationController pushViewController:NSClassFromString(@"DFLPushViewController").new animated:YES];
        //取消wkwebView加载此url
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"webview加载完毕");
    //执行js方法
    [webView evaluateJavaScript:@"OCCALLJS('杭州欢迎你')" completionHandler:nil];
}
#endif

@end
