//
//  JJCTencentManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCTencentManager.h"
#import "JJCTencentResponseManager.h"
#import "JJCTencentRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
@interface JJCTencentManager()<JJCThirdPlatformResponseHandlerDelegate>
@end
@implementation JJCTencentManager
DEF_SINGLETON

-(void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 初始化qq模块
    [JJCTencentResponseManager sharedInstance];
}
/**
 第三方平台处理URL
 */
-(BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // QQ 授权
    if([TencentOAuth CanHandleOpenURL:url]&&[TencentOAuth HandleOpenURL:url]){
        return true;
    }
    if ([QQApiInterface handleOpenURL:url delegate:[JJCTencentResponseManager sharedInstance]]){
        return true;
    }
    return false;
}
/**
 第三方登录
 */
-(void)signInWithType:(JJCThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(JJC_SignInResultBlock)callback{
    self.signInResultBlock = callback;
    [JJCTencentResponseManager sharedInstance].delegate = self;
    [JJCTencentRequestManager sendAuthInViewController:viewController];
}

// 分享
-(void)doShareWithModel:(JJCThirdPlatformShareModel *)model{
    self.shareResultBlock = model.shareResultBlock;
    [JJCTencentResponseManager sharedInstance].delegate = self;
    BOOL shareResult = [JJCTencentRequestManager sendMessageWithModel:model];
    if(!shareResult){
        !self.shareResultBlock ?: self.shareResultBlock(JJCShareTypeQQ,JJCShareResultFailed,nil);
    }
}
/**
 第三方支付
 */
- (void)payWithPlateform:(JJCThirdPlatformType)payMethodType order:(JJCOrderModel*)order paymentBlock:(JJC_PaymentResultBlock)paymentBlock {
    self.paymentResultBlock = paymentBlock;
    // 使用QQ支付
    [JJCTencentResponseManager sharedInstance].delegate = self;
    [JJCTencentRequestManager payWithOrder:order];
}
-(BOOL)isAppInstalled{
    return [TencentOAuth iphoneQQInstalled] ||[TencentOAuth iphoneTIMInstalled];
}
@end
