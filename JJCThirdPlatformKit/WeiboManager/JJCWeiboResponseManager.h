//
//  JJCWeiboResponseManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
#import <WeiboSDK/WeiboSDK.h>
@interface JJCWeiboResponseManager : JJCBaseThirdPlatformResponseManager<WeiboSDKDelegate>
AS_SINGLETON
@end
