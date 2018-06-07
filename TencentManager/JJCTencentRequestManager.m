//
//  JJCTencentRequestManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCTencentRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCTencentResponseManager.h"
#import "JJCThirdPlatformModel.h"
#import "UIImage+scale.h"
#import "QQWalletSDK.h"
@implementation JJCTencentRequestManager
//登录
+(BOOL)sendAuthInViewController:(id)viewController{
   NSArray* permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    return [[JJCTencentResponseManager sharedInstance].tencentOAuth authorize:permissions inSafari:false];
}

//分享
+(BOOL)sendMessageWithModel:(JJCThirdPlatformShareModel *)model{
    QQApiObject* obj;
    if(JJCShareContentTypeVideo == model.mediaObject.contentType){
        obj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)] title:model.title description:model.text previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    }else if(JJCShareContentTypeImage == model.mediaObject.contentType){
        NSInteger maxSharedImageBytes = 5*1024*1024;//10M
        obj = [QQApiImageObject objectWithData:UIImageJPEGRepresentation([UIImage scaleImageWithOrgImage:model.image maxBytes:maxSharedImageBytes], 1.0)
    previewImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]]
    title:@""
        description :@""];
    }else{
        obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)]
                                       title:model.title
                                 description:model.text
                             previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
        
    }
    SendMessageToQQReq* request = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode send = 0;
    if(JJCShareTypeQQ == model.platform){
        send = [QQApiInterface sendReq:request];
    }else if (JJCShareTypeWechatLine == model.platform){
        send = [QQApiInterface SendReqToQZone:request];
    }
    return EQQAPISENDSUCESS == send;
}
//支付
+ (BOOL)payWithOrder:(JJCOrderModel *)order {
    //调起qq支付
    NSString* appID = [[JJCThirdPlatformManager sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeTencentQQ subType:JJCThirdPlatformSubTypePay];
    NSString* scheme = [[JJCThirdPlatformManager sharedInstance] URLSchemesWithPlaform:JJCThirdPlatformTypeTencentQQ subType:JJCThirdPlatformSubTypePay];
    [[QQWalletSDK sharedInstance] startPayWithAppId:appID
                                        bargainorId:order.partnerid
                                            tokenId:order.package
                                          signature:order.sign
                                              nonce:order.noncestr
                                             scheme:scheme
                                         completion:^(QQWalletErrCode errCode, NSString *errStr){
                                             // 支付完成的回调处理
                                             if (errCode == QQWalletErrCodeSuccess) {
                                                 // 对支付成功的处理
                                                 [[JJCTencentResponseManager sharedInstance] setPayResult:JJCPayResultSuccess];
                                             } else if (errCode == QQWalletErrCodeUserCancel) {
                                                 // 对支付取消的处理
                                                 [[JJCTencentResponseManager sharedInstance] setPayResult:JJCPayResultCancel];
                                             } else {
                                                 // 对支付失败的处理
                                                 [[JJCTencentResponseManager sharedInstance] setPayResult:JJCPayResultFailed];
                                             }
                                         }];
    
    return true;
}
@end
