//
//  DFLWebViewDelegate.h
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/19.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol DFLWebViewDelegate <JSExport>

/**
 此方法需要商定好

 @param dic js参数
 */
- (void)JSOC:(NSDictionary *)dic ;

/**
 此方法需要商定好js无参数方法
 */
- (void)JSOCNOPramas;
@end
