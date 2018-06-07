//
//  JJCWeiboResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWeiboResponseManager.h"
#import "JJCThirdPlatformModel.h"
#import <WeiboSDK/WeiboUser.h>
@implementation JJCWeiboResponseManager
DEF_SINGLETON


#pragma mark - WeiboSDKDelegate
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        if([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]){
            [self.delegate respManagerDidRecvMessageResponse:(response.statusCode == WeiboSDKResponseStatusCodeSuccess) platform:JJCShareTypeWeibo];
        }else if([self.delegate isKindOfClass:WBAuthorizeResponse.class]){
            WBAuthorizeResponse* authResponse = (WBAuthorizeResponse*)response;
            [self userWithAccessToken:[authResponse accessToken] userId:[authResponse userID]];
        }
    }
}
- (void)userWithAccessToken:(NSString *)accessToken userId:(NSString *)userId{
    [WBHttpRequest requestForUserProfile:userId withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if(error){
            if([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]){
                [self.delegate respManagerDidRecvAuthResponse:nil platform:JJCThirdPlatformTypeWeibo];
            }
        }else{
            JJCThirdPlatformUserInfo* user = [self.class userByTranslateSinaResult:result];
            user.userId = userId;
            user.tokenString = accessToken;
            if([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]){
                [self.delegate respManagerDidRecvAuthResponse:user platform:JJCThirdPlatformTypeWeibo];
            }
        }
    }];
}
+ (JJCThirdPlatformUserInfo *)userByTranslateSinaResult:(id)result {
    JJCThirdPlatformUserInfo *user = [[JJCThirdPlatformUserInfo alloc] init];
    user.thirdPlatformType = JJCThirdPlatformTypeWeibo;
    
    if ([result isKindOfClass:[WeiboUser class]]) {
        WeiboUser *wbUser = (WeiboUser *)result;
        user.username = wbUser.screenName;
        user.gender = wbUser.gender;
        user.head = wbUser.avatarLargeUrl;
    }
    return user;
}
@end
