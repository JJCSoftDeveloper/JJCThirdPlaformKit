//
//  WebViewController.m
//  SKeyboardDemo
//
//  Created by zk on 15/12/2.
//  Copyright © 2015年 zk. All rights reserved.
//

#import "CMBUIWebViewController.h"

#import <cmbkeyboard/CMBWebKeyboard.h>


@interface CMBUIWebViewController ()

@end

@implementation CMBUIWebViewController {
    NSURL *_requestUrl;
    
}


- (void)loadUrl:(NSURL*)outerURL
{

    _requestUrl = outerURL;
    
}


- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame: self.view.bounds];
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
     [_webView loadRequest: [NSURLRequest requestWithURL:_requestUrl]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
}


- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    // 如果响应的地址是cmbls，则拦截
    if ([request.URL.host.lowercaseString isEqual:@"cmbls"]) {
        CMBWebKeyboard *secKeyboard = [CMBWebKeyboard shareInstance];
        [secKeyboard showKeyboardWithRequest:request];
        secKeyboard.webView = webView;
        
        return NO;
    }

    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Load webView error:%@", [error localizedDescription]);
}


#pragma mark - dealloc
- (void)dealloc
{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
        self.webView.delegate = nil;
    }
}



@end
