//
//  JJCTencentResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCTencentResponseManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
@implementation JJCTencentResponseManager
DEF_SINGLETON
-(instancetype)init{
    if(self = [super init]){
        NSString* appID = [[JJCThirdPlatformManager sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeTencentQQ subType:JJCThirdPlatformSubTypeAuthShare];
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appID andDelegate:self];
    }
    return self;
}
-(TencentOAuth *)tencentOAuth{
    if(!_tencentOAuth){
        NSString* appID = [[JJCThirdPlatformManager sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeTencentQQ subType:JJCThirdPlatformSubTypeAuthShare];
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appID andDelegate:self];
    }
    return _tencentOAuth;
}
#pragma mark - TencentLoginDelegate

/**
 * 登录成功后的回调
 */
-(void)tencentDidLogin{
    NSLog(@"===");
    [self.tencentOAuth getUserInfo];
}
/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]){
        [self.delegate respManagerDidRecvAuthResponse:nil platform:JJCThirdPlatformTypeTencentQQ];
    }
}
/**
 * 登录时网络有问题的回调
 */
-(void)tencentDidNotNetWork{
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
        [self.delegate respManagerDidRecvAuthResponse:nil platform:JJCThirdPlatformTypeTencentQQ];
    }
}
#pragma mark - TencentSessionDelegate
/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
-(void)getUserInfoResponse:(APIResponse *)response{
    if (URLREQUEST_SUCCEED == response.retCode
        && kOpenSDKErrorSuccess == response.detailRetCode) {
        JJCThirdPlatformUserInfo* user = [self.class getUserbyTranslateTencentResult:response.jsonResponse];
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
            [self.delegate respManagerDidRecvAuthResponse:user platform:JJCThirdPlatformTypeTencentQQ];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
            [self.delegate respManagerDidRecvAuthResponse:nil platform:JJCThirdPlatformTypeTencentQQ];
        }
    }
}
+ (JJCThirdPlatformUserInfo *)getUserbyTranslateTencentResult:(id)result {
    JJCThirdPlatformUserInfo *user = [[JJCThirdPlatformUserInfo alloc] init];
    user.thirdPlatformType = JJCThirdPlatformTypeTencentQQ;
    if ([result isKindOfClass:[NSDictionary class]]) {
        user.gender = [result objectForKey:@"gender"];
        user.username = [result objectForKey:@"nickname"];
        user.head = [result objectForKey:@"figureurl_qq_2"];
        NSString *year = [result objectForKeyedSubscript:@"year"];
        NSDateFormatter *dateFoematter = [[NSDateFormatter alloc] init];
        [dateFoematter setDateFormat:@"yyyy"];
        NSString *currDate = [dateFoematter stringFromDate:[NSDate date]];
        int ageNum = [currDate intValue] - [year intValue];
        user.age = [NSString stringWithFormat:@"%d",ageNum];
    }
    return user;
}
/**
 * 社交API统一回调接口
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
 */
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
    
}
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    NSLog(@"===");
}
/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"===");
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]) {
            if ([resp.result isEqualToString:@"0"]) {
                [self.delegate respManagerDidRecvMessageResponse:YES platform:JJCShareTypeQQ];
            } else {
                [self.delegate respManagerDidRecvMessageResponse:NO platform:JJCShareTypeQQ];
            }
        }
    }
}
/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    NSLog(@"===");
}


#pragma mark - Public
-(void)setPayResult:(JJCPayResult)payResult{
    if([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]){
        [self.delegate respManagerDidRecvPayResponse:payResult platform:JJCThirdPlatformTypeTencentQQ];
    }
}
@end
