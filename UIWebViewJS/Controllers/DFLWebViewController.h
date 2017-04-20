//
//  DFLWebViewController.h
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/19.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFLWebViewDelegate.h"

@interface DFLWebViewController : UIViewController

@property (nonatomic, assign) id<DFLWebViewDelegate>delegate;

@end
