//
//  CMBWebKeyboard.h
//  SKeyboardTest
//
//  Created by zk on 16/2/23.
//  Copyright © 2016年 zkr. All rights reserved.
//

#ifndef CMBWebKeyboard_h
#define CMBWebKeyboard_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


#if TARGET_OS_IPHONE
NS_CLASS_AVAILABLE_IOS(8_0)
#define WEBVIEW WKWebView
#elif NS_CLASS_AVAILABLE_IOS(2_0)
#define WEBVIEW UIWebView
#endif



@interface CMBWebKeyboard : NSObject
@property (nonatomic, strong) WEBVIEW *webView;

+ (CMBWebKeyboard *)shareInstance;

- (void)showKeyboardWithRequest:(NSURLRequest *)request;
- (void)hideKeyboard;
@end


#endif /* CMBWebKeyboard_h */
