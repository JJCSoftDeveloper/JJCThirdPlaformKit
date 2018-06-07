//
//  JJCCMBRequestManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCCMBRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCCMBResponseManager.h"
#import "CMBWKWebViewController.h"
#import "JJCThirdPlatformModel.h"
@implementation JJCCMBRequestManager
// 支付
+(BOOL)payWithOrder:(JJCOrderModel *)order{
    NSString* orderString = order.sign;
    NSString* appScheme = [[JJCThirdPlatformManager sharedInstance] URLSchemesWithPlaform:JJCThirdPlatformTypeAlipay subType:JJCThirdPlatformSubTypePay];
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//        [[JJCCMBResponseManager sharedInstance] setResponse:resultDic];
//    }];
    CMBWKWebViewController* vc = [[CMBWKWebViewController alloc] init];
    vc.sign = orderString;
    vc.requestURL = appScheme;
    vc.getPaymentResultBlock = ^{
       JJC_PaymentResultSettingHandler handler = [[JJCThirdPlatformManager sharedInstance] ResultSettingHandlerWithPlaform:JJCThirdPlatformTypeCMB];
        JJC_PaymentResultRequestSettingBlock responseCallback = ^(JJCPayResult result){
            [[JJCCMBResponseManager sharedInstance] setPayResult:result];
        };
        handler(responseCallback);
    };
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        if (window.windowLevel == UIWindowLevelNormal) {
            [window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:true completion:nil];
            break;
        }
    }
    return true;
}
@end
