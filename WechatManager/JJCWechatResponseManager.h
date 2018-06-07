//
//  JJCWechatResponseManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
#import <WXApi.h>
@interface JJCWechatResponseManager : JJCBaseThirdPlatformResponseManager<WXApiDelegate>
AS_SINGLETON
@end
