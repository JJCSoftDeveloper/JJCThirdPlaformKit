//
//  CMBWebViewController.h
//  SKeyboardDemo
//
//  Created by zk on 15/12/2.
//  Copyright © 2015年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CMBUIWebViewController : UIViewController<UIWebViewDelegate>


@property (nonatomic, strong) UIWebView *webView;

- (void)loadUrl:(NSURL*)outerURL;

@end
