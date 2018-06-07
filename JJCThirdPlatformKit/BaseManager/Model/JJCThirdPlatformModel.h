//
//  JJCThirdPlatformModel.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/14.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCThirdPlatformDefine.h"

@interface JJCSharedObject : NSObject
@property (nonatomic, assign) JJCShareContentType contentType;
@end


@interface JJCSharedVideoObject : JJCSharedObject
/**
 视频网页的url
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 视频lowband网页的url
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandUrl;
@end


@interface JJCSharedWebPageObject : JJCSharedObject
/**
 网页的url地址
 
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *webpageUrl;
@end

@interface JJCSharedImageObject : JJCSharedObject
/**
 网页的url地址
 
 @warning 不能为空且最大不超过5M （由于QQ图片大小最大为5M ，微信和微博为10M）
 */
@property (nonatomic, strong) NSData *imageData;
@end


#pragma mark - ......::::::: ThirdPlatformUserInfo :::::::......

@interface JJCThirdPlatformUserInfo : NSObject
@property (nonatomic, assign) JJCThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* openid;///<微信openid
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* head;
@property (nonatomic, copy) NSString* age;
@property (nonatomic, copy) NSString* gender;
@property (nonatomic, strong) NSDate* expirationDate;
@property (nonatomic, strong) NSString* tokenString;

@end


@interface JJCThirdPlatformShareModel : NSObject
@property (nonatomic, assign) JJCShareType platform;
@property (nonatomic, strong) JJCSharedObject* mediaObject;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSString* imageUrlString;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* weiboText;
@property (nonatomic, strong) NSString* urlString;
@property (nonatomic, strong) UIViewController* fromViewController;
@property (nonatomic, copy) void (^shareResultBlock)(JJCShareType pplatform, JJCShareResult result, NSError *);

@end

@interface JJCThirdPlatformLoginModel : NSObject
@property (nonatomic, assign) JJCThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* icon;
@property (nonatomic, copy) NSString* name;

@end

@interface JJCOrderModel : NSObject
/** 商户号id：  财付通商户号 微信商户号 */
@property (nonatomic, retain) NSString *partnerid;
/** 订单id： 微信预支付订单id  CMB订单id*/
@property (nonatomic, retain) NSString *prepayid;//

/** 随机串，防重发 */
@property (nonatomic, retain) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, retain) NSString *package;
/** 数据签名后的字符串： 支付宝签名后的字符串 CMB签名后的字符串 微信签名后的字符串 */
@property (nonatomic, retain) NSString *sign;
///** 订单号 */
//@property (nonatomic, strong) NSString* orderID;


@end

// 第三方平台的配置信息
@interface JJCThirdPlatformConfig : NSObject
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *redirectURL;
@property (nonatomic, copy) NSString *URLSchemes;
@end




