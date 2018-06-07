//
//  JJCThirdPlatformRequestHandler.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCThirdPlatformDefine.h"

@class JJCOrderModel, JJCThirdPlatformShareModel;

@protocol JJCThirdPlatformRequestHandler <NSObject>

@optional

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController;

// 支付
+ (BOOL)payWithOrder:(JJCOrderModel*)order;

// 分享
+ (BOOL)sendMessageWithModel:(JJCThirdPlatformShareModel*)model;

@end
