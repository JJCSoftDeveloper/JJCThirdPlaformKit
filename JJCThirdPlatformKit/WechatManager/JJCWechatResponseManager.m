//
//  JJCWechatResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWechatResponseManager.h"
#import "JJCThirdPlatformModel.h"
#import "JJCThirdPlatformManager.h"
#import <WeiboSDK/WeiboUser.h>
#import "NetworkRequestHelper.h"
#import "NSData+json.h"
@implementation JJCWechatResponseManager
DEF_SINGLETON


#pragma mark - WXApiDelegate

-(void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:SendMessageToWXResp.class]){
        if([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]){
            [self.delegate respManagerDidRecvMessageResponse:(resp.errCode == WXSuccess) platform:JJCShareTypeWeibo];
        }
    }else if([self.delegate isKindOfClass:SendAuthResp.class]){
        if (resp.errCode == WXSuccess) {
            NSString* appID = [[JJCThirdPlatformManager sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeWechat];
            NSString* appSecret = [[JJCThirdPlatformManager sharedInstance] appSecretWithPlaform:JJCThirdPlatformTypeWechat];
            [NetworkRequestHelper requestWithURLString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appID,appSecret,[(SendAuthResp*)resp code]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary* resultDict = [data jsonObject];
                [self userWithAccessToken:[resultDict objectForKey:@"access_token"] openID:[resultDict objectForKey:@"openid"]];
            }];
        }else{
            if([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]){
                [self.delegate respManagerDidRecvAuthResponse:nil platform:JJCThirdPlatformTypeWechat];
            }
        }
    }
}
- (void)userWithAccessToken:(NSString *)accessToken openID:(NSString *)openID{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", accessToken, openID];
    [NetworkRequestHelper requestWithURLString:urlString completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *resultDict = [data jsonObject];
        JJCThirdPlatformUserInfo* userInfo = [[JJCThirdPlatformUserInfo alloc] init];
        userInfo.userId = [resultDict objectForKey:@"unionid"];
        userInfo.openid = [resultDict objectForKey:@"openid"];
        userInfo.username = [resultDict objectForKey:@"nickname"];
        userInfo.head = [resultDict objectForKey:@"headimgurl"];
        userInfo.tokenString = accessToken;
        JJCThirdPlatformOnMainThreadAsync(^{
            if([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]){
                [self.delegate respManagerDidRecvAuthResponse:userInfo platform:JJCThirdPlatformTypeWechat];
            }
        });
    }];
}
@end
