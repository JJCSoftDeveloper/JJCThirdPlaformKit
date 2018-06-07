//
//  JJCCMBResponseManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
@interface JJCCMBResponseManager : JJCBaseThirdPlatformResponseManager
AS_SINGLETON
// 设置响应支付结果
- (void)setPayResult:(JJCPayResult)payResult;
@end
