//
//  CMBWebViewController.h
//  SKeyboardDemo
//
//  Created by zk on 15/12/2.
//  Copyright © 2015年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <WebKit/WKWebView.h>

typedef NS_ENUM(NSInteger,CMBPayFrom){
    CMBPayFrom_ORDERTVC = 0,
    CMBPayFrom_UNPAYVC = 1
};
typedef void (^GetPaymentResultBlock)(void);
@interface CMBWKWebViewController :  UIViewController<WKNavigationDelegate, WKUIDelegate>


@property (nonatomic, strong) WKWebView*    webView;
@property (nonatomic, copy  ) NSString*     sign;
//@property (nonatomic, copy  ) NSString*     orderID;
//@property (nonatomic, copy  ) NSString*     tradeID;
//@property (nonatomic, assign) float         price;
//@property (nonatomic, copy  ) NSString*     agrNo;//协议号
//@property (nonatomic, copy  ) NSString*     merchantSerialNo;//协议流水号
//@property (nonatomic, assign) CMBPayFrom    from;
@property (nonatomic, copy  ) NSString*     requestURL;
@property (nonatomic, copy  ) GetPaymentResultBlock getPaymentResultBlock;
@end
