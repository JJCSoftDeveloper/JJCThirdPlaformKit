//
//  JJCThirdPlatformManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformHandler.h"
#import "JJCThirdPlatformModel.h"

typedef NS_ENUM(NSUInteger, JJCThirdPlatformConfigKey) {
    JJCThirdPlatformAppID,
    JJCThirdPlatformAppKey,
    JJCThirdPlatformAppSecret,
    JJCThirdPlatformRedirectURI,
    JJCThirdPlatformURLSchemes,
    JJCThirdPlatformResultSettingHandler,
};
@interface JJCThirdPlatformManager ()
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformKeysConfig;
@property (nonatomic, strong) NSMutableSet* thirdPlatformManagerClasses;
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformManagerConfig;
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformShareManagerConfig;
//@property (nonatomic, strong) NSMutableDictionary* thirdPlatformShareManagerConfig;
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformCustomResultSetting;
@end

@implementation JJCThirdPlatformManager
DEF_SINGLETON

#pragma mark - ......::::::: JJCThirdPlatformHandler Override :::::::......

/**
 第三方平台配置
 */
- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(JJCThirdPlatformHandler)]) {
            [manager thirdPlatConfigWithApplication:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(JJCThirdPlatformHandler)]) {
            BOOL result = [manager thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
            if (result) {
                return YES;
            }
        }
    }
    return NO;
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(JJCThirdPlatformType)thirdPlatformType
    fromViewController:(UIViewController *)viewController
              callback:(JJC_SignInResultBlock)callback {
    NSString* classString = [[self thirdPlatformManagerConfig] objectForKey:@(thirdPlatformType)];
    id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
    [manager signInWithType:thirdPlatformType
         fromViewController:viewController
                   callback:callback];
}


/**
 第三方分享
 
 @param model 分享数据
 */
- (void)shareWithModel:(JJCThirdPlatformShareModel *)model {
    NSString* classString = [[self thirdPlatformShareManagerConfig] objectForKey:@(model.platform)];
    id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
    [manager shareWithModel:model];
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(JJCThirdPlatformType)payMethodType order:(JJCOrderModel*)order paymentBlock:(JJC_PaymentResultBlock)paymentBlock {
    NSString* classString = [[self thirdPlatformManagerConfig] objectForKey:@(payMethodType)];
    id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
    [manager payWithPlateform:payMethodType
                        order:order
                 paymentBlock:paymentBlock];
}

// APP是否安装
- (BOOL)isThirdPlatformInstalledForShare:(JJCShareType)thirdPlatform {
    NSString* classString = [[self thirdPlatformShareManagerConfig] objectForKey:@(thirdPlatform)];
    id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
    return [manager isAppInstalled];
}

// APP是否安装
- (BOOL)isThirdPlatformInstalled:(JJCThirdPlatformType)thirdPlatform {
    NSString* classString = [[self thirdPlatformManagerConfig] objectForKey:@(thirdPlatform)];
    id<JJCThirdPlatformHandler> manager = [self managerFromClassString:classString];
    return [manager isAppInstalled];
}

#pragma mark - ......::::::: JJCThirdPlatformConfigurable Override :::::::......

- (BOOL)setPlaform:(JJCThirdPlatformType)platformType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes {
    [self setPlaform:platformType subType:JJCThirdPlatformSubTypeTotal appID:appID appKey:appKey appSecret:appSecret redirectURL:redirectURL URLSchemes:URLSchemes];
    return YES;
}

- (BOOL)setPlaform:(JJCThirdPlatformType)platformType
           subType:(JJCThirdPlatformSubType)subType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes {
    NSDictionary* subTypeConfig = @{@(JJCThirdPlatformAppID): ValueOrEmpty(appID),
                                    @(JJCThirdPlatformAppKey): ValueOrEmpty(appKey),
                                    @(JJCThirdPlatformAppSecret): ValueOrEmpty(appSecret),
                                    @(JJCThirdPlatformRedirectURI): ValueOrEmpty(redirectURL),
                                    @(JJCThirdPlatformURLSchemes): ValueOrEmpty(URLSchemes),
                                    };
    
    if (![self.thirdPlatformKeysConfig objectForKey:@(platformType)]) {
        [self.thirdPlatformKeysConfig setObject:[@{} mutableCopy] forKey:@(platformType)];
    }
    
    [[self.thirdPlatformKeysConfig objectForKey:@(platformType)] setObject:subTypeConfig forKey:@(subType)];
    return YES;
}

- (NSString*)appIDWithPlaform:(JJCThirdPlatformType)platformType {
    return [self appIDWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}

- (NSString*)appKeyWithPlaform:(JJCThirdPlatformType)platformType {
    return [self appKeyWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}

- (NSString*)appSecretWithPlaform:(JJCThirdPlatformType)platformType {
    return [self appSecretWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}

- (NSString*)appRedirectURLWithPlaform:(JJCThirdPlatformType)platformType {
    return [self appRedirectURLWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}

- (NSString*)URLSchemesWithPlaform:(JJCThirdPlatformType)platformType {
    return [self URLSchemesWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}
-(JJC_PaymentResultSettingHandler)ResultSettingHandlerWithPlaform:(JJCThirdPlatformType)platformType{
    return [self ResultSettingHandlerWithPlaform:platformType subType:JJCThirdPlatformSubTypeTotal];
}

- (NSString*)appIDWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformAppID)];
}

- (NSString*)appKeyWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformAppKey)];
}

- (NSString*)appSecretWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformAppSecret)];
}

- (NSString*)appRedirectURLWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformRedirectURI)];
}

- (NSString*)URLSchemesWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformURLSchemes)];
}
-(JJC_PaymentResultSettingHandler)ResultSettingHandlerWithPlaform:(JJCThirdPlatformType)platformType subType:(JJCThirdPlatformSubType)subType{
    return [[[self.thirdPlatformCustomResultSetting objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(JJCThirdPlatformResultSettingHandler)];
}
#pragma mark 插件接入点
/**
 插件接入点-添加支付管理类的支付结果方式
 
 @param settingHandler 自定义的支付结果获取设置，
 @param platformType 平台类型 @see JJCThirdPlatformType 或者自定义第三方平台类型
 */
- (void)addCustomPayResultRequestSetting:(JJC_PaymentResultSettingHandler)settingHandler withPlatform:(NSInteger)platformType{
    if (![self.thirdPlatformCustomResultSetting objectForKey:@(platformType)]) {
        [self.thirdPlatformCustomResultSetting setObject:[@{} mutableCopy] forKey:@(platformType)];
    }
    
    [[self.thirdPlatformCustomResultSetting objectForKey:@(platformType)] setObject:settingHandler forKey:@(JJCThirdPlatformSubTypeTotal)];
}
/**
 插件接入点-添加登录或者是支付的管理类
 
 @param platformType 自定义的第三方平台类型，大于999
 @param managerClass 实现了JJCThirdPlatformHandler接口的自定义第三方平台管理类
 */
- (void)addCustomPlatform:(NSInteger)platformType managerClass:(Class)managerClass {
    NSString* classString = NSStringFromClass(managerClass);
    if (classString) {
        [self.thirdPlatformManagerConfig setObject:NSStringFromClass(managerClass) forKey:@(platformType)];
        [self.thirdPlatformManagerClasses addObject:classString];
    }
}

/**
 插件接入点-添加分享的管理类
 
 @param sharePlatformType 自定义的第三方平台分享类型，大于999
 @param managerClass 实现了JJCThirdPlatformHandler接口的自定义第三方平台管理类
 */
- (void)addCustomSharePlatform:(NSInteger)sharePlatformType managerClass:(Class)managerClass {
    NSString* classString = NSStringFromClass(managerClass);
    if (classString) {
        [self.thirdPlatformShareManagerConfig setObject:classString forKey:@(sharePlatformType)];
        [self.thirdPlatformManagerClasses addObject:classString];
    }
}

#pragma mark - ......::::::: Config :::::::......

- (id)managerFromClassString:(NSString*)classString {
    if (classString == nil || classString.length == 0) {
        return nil;
    }
    Class clz = NSClassFromString(classString);
    SEL sharedInstanceSelector = @selector(sharedInstance);
    id<JJCThirdPlatformHandler> manager = nil;
    if(clz && [clz respondsToSelector:sharedInstanceSelector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 这里的警告可以直接忽略，返回的是一个单例对象，不会有泄漏问题
        manager = [clz performSelector:sharedInstanceSelector];
#pragma clang diagnostic pop
    }
    return manager;
}

// 配置管理类的类名
- (NSMutableSet*)thirdPlatformManagerClasses {
    if (nil == _thirdPlatformManagerClasses) {
        _thirdPlatformManagerClasses = [[NSMutableSet alloc] init];
        [_thirdPlatformManagerClasses
         addObjectsFromArray:@[@"JJCAlipayManager",
                               @"JJCTencentManager",
                               @"JJCWeiboManager",
                               @"JJCWXManager",
                               ]];
    }
    return _thirdPlatformManagerClasses;
}

// 配置第三方登录支付对应的管理类
- (NSMutableDictionary*)thirdPlatformManagerConfig {
    if (nil == _thirdPlatformManagerConfig) {
        _thirdPlatformManagerConfig = [[NSMutableDictionary alloc] init];
        [_thirdPlatformManagerConfig addEntriesFromDictionary:
         @{
           @(JJCThirdPlatformTypeWechat): @"JJCWXManager",
           @(JJCThirdPlatformTypeTencentQQ): @"JJCTencentManager",
           @(JJCThirdPlatformTypeWeibo): @"JJCWeiboManager",
           @(JJCThirdPlatformTypeAlipay): @"JJCAlipayManager",
           }];
    }
    return _thirdPlatformManagerConfig;
}

// 配置第三方分享对应的管理类
- (NSMutableDictionary*)thirdPlatformShareManagerConfig {
    if (nil == _thirdPlatformShareManagerConfig) {
        _thirdPlatformShareManagerConfig = [[NSMutableDictionary alloc] init];
        [_thirdPlatformShareManagerConfig addEntriesFromDictionary:
         @{
           @(JJCShareTypeWechat): @"JJCWXManager",
           @(JJCShareTypeWechatLine): @"JJCWXManager",
           @(JJCShareTypeQQ): @"JJCTencentManager",
           @(JJCShareTypeQQZone): @"JJCTencentManager",
           @(JJCShareTypeWeibo): @"JJCWeiboManager",
           }];
    }
    return _thirdPlatformShareManagerConfig;
}

// 第三方平台的APPID/APPKEY/APPSECRET等信息
- (NSMutableDictionary*)thirdPlatformKeysConfig {
    if (!_thirdPlatformKeysConfig) {
        _thirdPlatformKeysConfig = [[NSMutableDictionary alloc] init];
    }
    return _thirdPlatformKeysConfig;
}
// 第三方平台自定义的结果请求
- (NSMutableDictionary*)thirdPlatformCustomResultSetting {
    if (!_thirdPlatformCustomResultSetting) {
        _thirdPlatformCustomResultSetting = [[NSMutableDictionary alloc] init];
    }
    return _thirdPlatformCustomResultSetting;
}
@end
