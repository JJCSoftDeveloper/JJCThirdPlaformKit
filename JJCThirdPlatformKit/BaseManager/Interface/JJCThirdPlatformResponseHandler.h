//
//  JJCThirdPlatformResponseHandler.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJCThirdPlatformDefine.h"

@class JJCThirdPlatformUserInfo;

@protocol JJCThirdPlatformResponseHandlerDelegate <NSObject>

@optional

- (void)respManagerDidRecvPayResponse:(JJCPayResult)result platform:(JJCThirdPlatformType)platform;
- (void)respManagerDidRecvAuthResponse:(JJCThirdPlatformUserInfo *)response platform:(JJCThirdPlatformType)platform;
- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(JJCShareType)platform;

@end


@protocol JJCThirdPlatformResponseHandler <NSObject>

@optional

// 代理，子类需要设置getter/setter
@property (nonatomic, weak) id<JJCThirdPlatformResponseHandlerDelegate> delegate;
@end
