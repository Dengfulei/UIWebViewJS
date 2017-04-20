//
//  DFLViewController.m
//  WKWebViewJS
//
//  Created by 杭州移领 on 17/4/12.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLViewController.h"

@interface DFLViewController ()

@end

@implementation DFLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 100, 60);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"WKWebView" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(WKWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *webButton = [UIButton new];
    webButton.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)+30, 100, 60);
    webButton.backgroundColor = [UIColor redColor];
    [webButton setTitle:@"WebView" forState:UIControlStateNormal];
    [webButton addTarget:self action:@selector(WebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webButton];
  
}

- (void)WebView {
    
    [self.navigationController pushViewController:NSClassFromString(@"DFLWebViewController").new animated:YES];
}

- (void)WKWebView {
    
    [self.navigationController pushViewController:NSClassFromString(@"DFLWKWebViewController").new animated:YES];
    
}
@end
