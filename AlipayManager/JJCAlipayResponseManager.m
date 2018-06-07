//
//  JJCAlipayResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCAlipayResponseManager.h"
#import "JJCThirdPlatformModel.h"
@implementation JJCAlipayResponseManager
DEF_SINGLETON
-(void)setResponse:(NSDictionary *)response{
    //解析 resultStatus
    NSString* resultStatusStr = [response objectForKey:@"resultStatue"];
    NSInteger resultStatues = 0;
    if([resultStatusStr respondsToSelector:@selector(integerValue)]){
        resultStatues = [resultStatusStr integerValue];
    }
    JJCPayResult payResult = (resultStatues == 9000) ? JJCPayResultSuccess : (resultStatues == 6001) ? JJCPayResultCancel : JJCPayResultFailed;
    if([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]){
        [self.delegate respManagerDidRecvPayResponse:payResult platform:JJCThirdPlatformTypeAlipay];
    }
}
@end
