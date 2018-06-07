//
//  JJCWeiboManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWeiboManager.h"
#import "JJCWeiboResponseManager.h"
#import "JJCWeiboRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
@interface JJCWeiboManager()<JJCThirdPlatformResponseHandlerDelegate>
@end
@implementation JJCWeiboManager
DEF_SINGLETON

-(void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 初始化微博模块
#if DEBUG
    [WeiboSDK enableDebugMode:true];
    NSLog(@"WeiboSDK getSDKVersion = %@", [WeiboSDK getSDKVersion]);
#endif
    NSString* appKey = [[JJCThirdPlatformManager  sharedInstance] appKeyWithPlaform:JJCThirdPlatformTypeWeibo];
    [WeiboSDK registerApp:appKey];
}
/**
 第三方平台处理URL
 */
-(BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if([WeiboSDK handleOpenURL:url delegate:[JJCWeiboResponseManager sharedInstance]]){
        return true;
    }
    return false;
}
/**
 第三方登录
 */
-(void)signInWithType:(JJCThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(JJC_SignInResultBlock)callback{
    self.signInResultBlock = callback;
    [JJCWeiboResponseManager sharedInstance].delegate = self;
    [JJCWeiboRequestManager sendAuthInViewController:viewController];
}

// 分享
-(void)doShareWithModel:(JJCThirdPlatformShareModel *)model{
    self.shareResultBlock = model.shareResultBlock;
    [JJCWeiboResponseManager sharedInstance].delegate = self;
    BOOL shareResult = [JJCWeiboRequestManager sendMessageWithModel:model];
    if(!shareResult){
        !self.shareResultBlock ?: self.shareResultBlock(model.platform,JJCShareResultFailed,nil);
    }
}
-(BOOL)isAppInstalled{
    return [WeiboSDK isWeiboAppInstalled];
}
@end
