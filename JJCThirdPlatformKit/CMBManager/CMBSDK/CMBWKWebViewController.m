//
//  WebViewController.m
//  SKeyboardDemo
//
//  Created by zk on 15/12/2.
//  Copyright © 2015年 zk. All rights reserved.
//

#import "CMBWKWebViewController.h"
#import <cmbkeyboard/CMBWebKeyboard.h>
//#import "JJCThirdPlatformManager.h"
@import WebKit;


@interface CMBWKWebViewController ()
@property (nonatomic,assign)BOOL        needLoadJSPOST;
@property (nonatomic,copy  )NSString*   bodyStr;
@property (nonatomic,strong)UIView*     overlay;
@end

@implementation CMBWKWebViewController {
    
    
}

- (void)viewDidLoad
{
    
    self.title = @"一网通支付";
    self.view.backgroundColor = [UIColor whiteColor];
    self.needLoadJSPOST = true;
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    UIButton* backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(checkPayResut) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame: self.view.bounds];
    //_webView.frame = self.view.frame;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
   
    
    [self.view addSubview:_webView];
    

//    NSDate* nowTime = [NSDate date];
//    NSDateFormatter* format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"yyyyMMddHHmmss";
//    NSString* dateTimeStr = [format stringFromDate:nowTime];
//
//    format.dateFormat = @"yyyyMMdd";
//    NSString* dateStr = [format stringFromDate:nowTime];
//
//
//    NSDictionary* reqData = @{@"dateTime":dateTimeStr,@"branchNo":CMB_BRANCH_NO,@"merchantNo":CMB_MERCHANT_NO,@"date":dateStr,@"orderNo":self.tradeID,@"amount":[NSString stringWithFormat:@"%.2f",self.price],@"expireTimeSpan":@"30",@"payNoticeUrl":[NSString stringWithFormat:@"%@%@%@",CMB_API_URL,CMB_URL,CMB_PAY_RESULT_CALLBACK_URL],@"payNoticePara":self.tradeID,@"returnUrl":@"http://xiudoucmbnprm",@"cardType":@"",@"agrNo":self.agrNo,@"merchantSerialNo":self.merchantSerialNo,@"signNoticeUrl":[NSString stringWithFormat:@"%@%@%@",CMB_API_URL,CMB_URL,CMB_SIGN_NOTICE_CALLBACK_URL],@"signNoticePara":@"",@"userID":USER_ID,@"clientIP":@"",@"extendInfoEncrypType":@"",@"lat":@"",@"lon":@"",@"mobile":@"",@"riskLevel":@"",@"extendInfo":@""};
//    NSString* reqDataStr = [Utilities dictionaryToString:reqData];
//    NSString* strToSign = [reqDataStr stringByAppendingString:@"&1899dou188xiuABC"];
//    NSString* sign = [strToSign SHA256];
//    NSDictionary* jsonRequestData = @{@"version":@"1.0",@"charset":@"UTF-8",@"sign":sign,@"signType":@"SHA-256",@"reqData":reqData};
//
////    NSString *str = [NSString stringWithFormat:@"version=%@&charset=%@&sign=%@&signType=%@&reqData=%@",@"1.0",@"UTF-8",sign,@"SHA-256",[Utilities arrayAndDictToJson:reqData]];
//    NSString* value = [Utilities arrayAndDictToJson:jsonRequestData];
//    value = [value stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    value = [value stringByReplacingOccurrencesOfString:@"{" withString:@"\\{"];
//    value = [value stringByReplacingOccurrencesOfString:@"}" withString:@"\\}"];
//    NSString* str = [NSString stringWithFormat:@"\"jsonRequestData\":\"%@\"",value];
    self.bodyStr = [self.sign copy];
//     NSLog(@"reqData %@ \n strToSign %@\n sign %@ str %@",reqData,strToSign,sign,str);
   

    
   
//    NSURL *URL=[NSURL URLWithString:CMB_PAY_URL];
//    //    2.创建请求对象
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
//    request.timeoutInterval=5.0;//设置请求超时为5秒
//    request.HTTPMethod=@"POST";//设置请求方法
//    //设置请求体
//    request.HTTPBody=[str dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:API_URL]];
//    [_webView loadRequest: request];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//同步发送request，成功后会得到服务器返回的数据
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
//
//    [_webView loadData:returnData MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:nil];
//    NSString *string = [[NSString alloc]initWithData:returnData encoding:enc];
//    [_webView loadHTMLString:string baseURL:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CMBJSPOST" ofType:@"html"];
    // 获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    // 加载js
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}
-(void)initNavigationSetting{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    CGFloat height = ([[UIScreen mainScreen] bounds].size.height == 812.0? 44:20);
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, 44+height)];
    self.overlay.userInteractionEnabled = NO;
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.navigationController.navigationBar insertSubview:self.overlay atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

#pragma mark - WKNavigationDelegate


/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    // 如果响应的地址是cmbls，则拦截
    if([navigationAction.request.URL.absoluteString containsString:@"http://xiudoucmbnprm"]){
        [self checkPayResut];
    }
    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"cmbls"]) {
        CMBWebKeyboard *secKeyboard = [CMBWebKeyboard shareInstance];
        [secKeyboard showKeyboardWithRequest: navigationAction.request];
        secKeyboard.webView = webView;
        
        // 不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel );
        return;
    }else
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);

}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 判断是否需要加载（仅在第一次加载）
    if (self.needLoadJSPOST) {
        // 调用使用JS发送POST请求的方法
        [self postRequestWithJS];
        // 将Flag置为NO（后面就不需要加载了）
        self.needLoadJSPOST = NO;
    }
}
// 调用JS发送POST请求
- (void)postRequestWithJS {
    // 发送POST的参数
    NSString *postData = self.bodyStr;
    // 请求的页面地址
    NSString *urlStr = self.requestURL;
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@', {%@});", urlStr, postData];
    
    // NSLog(@"Javascript: %@", jscript);
    // 调用JS代码
    [self.webView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
        
    }];
}
-(void)backAction{
    if(!self.navigationController){
        [self dismissViewControllerAnimated:true completion:nil];
    }else if(self.navigationController.viewControllers.count == 1){
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)checkPayResut{
    if(self.getPaymentResultBlock){
        self.getPaymentResultBlock();
        self.getPaymentResultBlock = nil;
    }
//    [AFHTTPSessionManager requestMethod3:@"POST" URL:ORDER_PAY_STATUES model:ORDER_URL params:@{@"auth_token": TOKEN,@"trade_id":self.tradeID} version:@"2.7.3" success:^(id JSON) {
//        [self backAction];
//        if([[JSON valueForKey:@"code"] intValue] == 0){
//            NSInteger status = [[JSON valueForKey:@"pay_status"] intValue];
//            if(status == 1){
//                [[NSNotificationCenter defaultCenter] postNotificationName:CMBPAY_SUCCESS_NOTIFICATION object:@"PaySuccess"];
//            }else{
//                [[NSNotificationCenter defaultCenter] postNotificationName:CMBPAY_SUCCESS_NOTIFICATION object:@"PayFailed"];
//            }
//        }
//    } error:^(NSHTTPURLResponse *response, NSError *error, id JSON) {
//        [self backAction];
//    }];
}
#pragma mark - dealloc
- (void)dealloc
{
    [[CMBWebKeyboard shareInstance] hideKeyboard];
    
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
        self.webView.navigationDelegate = nil;
        self.webView.UIDelegate = nil;
    }
}

@end
