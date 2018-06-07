//
//  JJCThirdPlatformHandler.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JJCThirdPlatformDefine.h"

@class JJCOrderModel, JJCThirdPlatformUserInfo, JJCThirdPlatformShareModel;

typedef void(^JJC_PaymentResultBlock)(JJCThirdPlatformType payType, JJCPayResult result);
typedef void(^JJC_SignInResultBlock)(JJCThirdPlatformUserInfo* userInfo, NSError* err);
typedef void(^JJC_ShareResultBlock)(JJCShareType shareType, JJCShareResult, NSError* err);

typedef void (^JJC_PaymentResultRequestSettingBlock)(JJCPayResult result);
typedef void (^JJC_PaymentResultSettingHandler)(JJC_PaymentResultRequestSettingBlock requestBlock);

@protocol JJCThirdPlatformHandler <NSObject>

@optional

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation;

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(JJCThirdPlatformType)thirdPlatformType
    fromViewController:(UIViewController *)viewController
              callback:(JJC_SignInResultBlock)callback;

/**
 第三方分享
 */
- (void)shareWithModel:(JJCThirdPlatformShareModel*)model;

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(JJCThirdPlatformType)payMethodType order:(JJCOrderModel*)order paymentBlock:(JJC_PaymentResultBlock)paymentBlock;

// APP是否安装
- (BOOL)isAppInstalled;

// APP是否安装
- (BOOL)isThirdPlatformInstalledForShare:(JJCShareType)thirdPlatform;

// APP是否安装
- (BOOL)isThirdPlatformInstalled:(JJCThirdPlatformType)thirdPlatform;

@end

