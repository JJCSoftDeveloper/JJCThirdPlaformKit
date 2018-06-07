//
//  JJCThirdPlatformDefine.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/14.
//  Copyright © 2018年 jjc. All rights reserved.
//

#ifndef JJCThirdPlatformDefine_h
#define JJCThirdPlatformDefine_h

// 单例工具宏
#undef    AS_SINGLETON
#define AS_SINGLETON \
+ (instancetype)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
} \

// 字符串工具宏
#define ValueOrEmpty(value)     ((value)?(value):@"")

//线程处理相关
static inline void JJCThirdPlatformOnMainThreadAsync(void (^block)(void)){
    if([NSThread isMainThread]) block();
    else dispatch_async(dispatch_get_main_queue(),block);
}

//第三方平台类型
typedef NS_ENUM(NSInteger,JJCThirdPlatformType){
    JJCThirdPlatformTypeWechat = 1000001,//微信
    JJCThirdPlatformTypeTencentQQ = 1000002,//腾讯QQ
    JJCThirdPlatformTypeWeibo = 1000003,//微博
    JJCThirdPlatformTypeAlipay = 1000004,//支付宝
    JJCThirdPlatformTypeCMB = 1000005,//CMB
};

// 第三方平台类型对应的子类型
typedef NS_ENUM(NSInteger, JJCThirdPlatformSubType) {
    JJCThirdPlatformSubTypeTotal = 1,//所有的子类型，不区分
    JJCThirdPlatformSubTypeAuthShare,//分享授权子类型
    JJCThirdPlatformSubTypePay,//支付子类型
};


// 分享类型
typedef NS_ENUM(NSInteger, JJCShareType) {
    JJCShareTypeUnknow = 200,
    JJCShareTypeWechat,
    JJCShareTypeWechatLine,
    JJCShareTypeQQ,
    JJCShareTypeQQZone,
    JJCShareTypeWeibo,
};

// 分享内容类型
typedef NS_ENUM(NSInteger, JJCShareContentType) {
    JJCShareContentTypeWebPage,
    JJCShareContentTypeVideo,
    JJCShareContentTypeImage,
};

// 分享结果
typedef NS_ENUM(NSInteger, JJCShareResult) {
    JJCShareResultSuccess,
    JJCShareResultFailed,
    JJCShareResultCancel,
};

// 支付结果结果
typedef NS_ENUM(NSInteger, JJCPayResult) {
    JJCPayResultSuccess,
    JJCPayResultFailed,
    JJCPayResultCancel,
};

#endif /* JJCThirdPlatformDefine_h */
