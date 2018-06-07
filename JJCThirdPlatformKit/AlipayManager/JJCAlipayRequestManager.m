//
//  JJCAlipayRequestManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCAlipayRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCAlipayResponseManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JJCThirdPlatformModel.h"
@implementation JJCAlipayRequestManager
// 支付
+(BOOL)payWithOrder:(JJCOrderModel *)order{
    NSString* orderString = order.sign;
    NSString* appScheme = [[JJCThirdPlatformManager sharedInstance] URLSchemesWithPlaform:JJCThirdPlatformTypeAlipay subType:JJCThirdPlatformSubTypePay];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        [[JJCAlipayResponseManager sharedInstance] setResponse:resultDic];
    }];
    return true;
}
@end
