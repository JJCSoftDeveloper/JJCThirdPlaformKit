//
//  JJCCMBResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCCMBResponseManager.h"
#import "JJCThirdPlatformModel.h"
@implementation JJCCMBResponseManager
DEF_SINGLETON
-(void)setPayResult:(JJCPayResult)payResult{
    if([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]){
        [self.delegate respManagerDidRecvPayResponse:payResult platform:JJCThirdPlatformTypeAlipay];
    }
}
@end
