//
//  JJCAlipayManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCAlipayManager.h"
#import "JJCAlipayResponseManager.h"
#import "JJCAlipayRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
#import <AlipaySDK/AlipaySDK.h>
@interface JJCAlipayManager()<JJCThirdPlatformResponseHandlerDelegate>
@end
@implementation JJCAlipayManager
DEF_SINGLETON

-(void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
}
/**
 第三方支付
 */
-(void)payWithPlateform:(JJCThirdPlatformType)payMethodType order:(JJCOrderModel *)order paymentBlock:(JJC_PaymentResultBlock)paymentBlock{
    self.paymentResultBlock = paymentBlock;
    [JJCAlipayResponseManager sharedInstance].delegate = self;
    [JJCAlipayRequestManager payWithOrder:order];
}
/**
 第三方平台处理URL
 */
-(BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result =%@",resultDic);
            [[JJCAlipayResponseManager sharedInstance] setResponse:resultDic];
        }];
        
         // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString* result = [resultDic objectForKey:@"result"];
            NSString* authCode = @"";
            if(result.length>0){
                NSArray* resultArray = [result componentsSeparatedByString:@"&"];
                for (NSString* subResult in resultArray) {
                    if(subResult.length>0&&[subResult hasPrefix:@"auth_token"]){
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            [[JJCAlipayResponseManager sharedInstance] setResponse:resultDic];
            NSLog(@"授权结果 authCode = %@",authCode?:@"");
            return true;
        }];
    }
    return false;
}

@end
