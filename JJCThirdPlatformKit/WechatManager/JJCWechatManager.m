//
//  JJCWechatManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWechatManager.h"
#import "JJCWechatResponseManager.h"
#import "JJCWechatRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
@interface JJCWechatManager()<JJCThirdPlatformResponseHandlerDelegate>
@end
@implementation JJCWechatManager
DEF_SINGLETON

-(void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 初始化微信模块
    NSString* appID = [[JJCThirdPlatformManager  sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeWeibo];
    [WXApi registerApp:appID];
}
/**
 第三方平台处理URL
 */
-(BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if([WXApi handleOpenURL:url delegate:[JJCWechatResponseManager sharedInstance]]){
        return true;
    }
    return false;
}
/**
 第三方登录
 */
-(void)signInWithType:(JJCThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(JJC_SignInResultBlock)callback{
    self.signInResultBlock = callback;
    [JJCWechatResponseManager sharedInstance].delegate = self;
    [JJCWechatRequestManager sendAuthInViewController:viewController];
}

// 分享
-(void)doShareWithModel:(JJCThirdPlatformShareModel *)model{
    self.shareResultBlock = model.shareResultBlock;
    [JJCWechatResponseManager sharedInstance].delegate = self;
    BOOL shareResult = [JJCWechatRequestManager sendMessageWithModel:model];
    if(!shareResult){
        !self.shareResultBlock ?: self.shareResultBlock(model.platform,JJCShareResultFailed,nil);
    }
}
-(BOOL)isAppInstalled{
    return [WXApi isWXAppInstalled];
}
@end
