//
//  JJCAlipayResponseManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
@interface JJCAlipayResponseManager : JJCBaseThirdPlatformResponseManager
AS_SINGLETON
// 设置响应结果
- (void)setResponse:(NSDictionary*)response;
@end
