//
//  JJCThirdPlatformConfigure.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJCThirdPlatformDefine.h"
#import "JJCThirdPlatformHandler.h"
@protocol JJCThirdPlatformConfigure <NSObject>

/**
 *  按需设置平台的appkey/appID/appSecret/redirectURL/URLSchemes
 *
 *  @param platformType 平台类型 @see JJCThirdPlatformType
 *  @param appKey       第三方平台的appKey
 *  @param appID        第三方平台的appID
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 *  @param URLSchemes   URLSchemes，目前支付宝使用到，调用支付宝的时候需要传递一个URLSchemes参数
 */
- (BOOL)setPlaform:(JJCThirdPlatformType)platformType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes;

/**
 *  按需设置平台的appkey/appID/appSecret/redirectURL/URLSchemes
 *  一个平台不同的功能对应不用的配置使用该方法配置
 *
 *  @param platformType 平台类型 @see JJCThirdPlatformType
 *  @param appKey       第三方平台的appKey
 *  @param appID        第三方平台的appID
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 *  @param URLSchemes   URLSchemes，目前支付宝使用到，调用支付宝的时候需要传递一个URLSchemes参数
 */
- (BOOL)setPlaform:(JJCThirdPlatformType)platformType
           subType:(JJCThirdPlatformSubType)subType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes;



- (NSString*)appIDWithPlaform:(JJCThirdPlatformType)platformType;
- (NSString*)appKeyWithPlaform:(JJCThirdPlatformType)platformType;
- (NSString*)appSecretWithPlaform:(JJCThirdPlatformType)platformType;
- (NSString*)appRedirectURLWithPlaform:(JJCThirdPlatformType)platformType;
- (NSString*)URLSchemesWithPlaform:(JJCThirdPlatformType)platformType;
- (JJC_PaymentResultSettingHandler)ResultSettingHandlerWithPlaform:(JJCThirdPlatformType)platformType;

- (NSString*)appIDWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;
- (NSString*)appKeyWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;
- (NSString*)appSecretWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;
- (NSString*)appRedirectURLWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;
- (NSString*)URLSchemesWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;

- (JJC_PaymentResultSettingHandler)ResultSettingHandlerWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType;
/**
 插件接入点-添加支付管理类的支付结果方式
 
 @param settingHandler 自定义的支付结果获取设置，
 @param platformType 平台类型 @see JJCThirdPlatformType 或者自定义第三方平台类型
 */
- (void)addCustomPayResultRequestSetting:(JJC_PaymentResultSettingHandler)settingHandler withPlatform:(NSInteger)platformType;
/**
 插件接入点-添加登录或者是支付的管理类
 
 @param platformType 自定义的第三方平台类型，大于999
 @param managerClass 实现了JJCThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomPlatform:(NSInteger)platformType managerClass:(Class)managerClass;

/**
 插件接入点-添加分享的管理类
 
 @param sharePlatformType 自定义的第三方平台分享类型，大于999
 @param managerClass 实现了JJCThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomSharePlatform:(NSInteger)sharePlatformType managerClass:(Class)managerClass;

@end
