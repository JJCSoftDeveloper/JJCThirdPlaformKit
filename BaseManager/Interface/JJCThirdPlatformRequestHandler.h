//
//  JJCThirdPlatformRequestHandler.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@class OrderModel, ThirdPlatformShareModel;

@protocol JJCThirdPlatformRequestHandler <NSObject>

@optional

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController;

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order;

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model;

@end
