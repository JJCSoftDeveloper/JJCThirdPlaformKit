//
//  JJCTencentResponseManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface JJCTencentResponseManager : JJCBaseThirdPlatformResponseManager<TencentSessionDelegate,QQApiInterfaceDelegate>
AS_SINGLETON

@property (nonatomic, strong) TencentOAuth* tencentOAuth;
- (void)setPayResult:(JJCPayResult)payResult;
@end
