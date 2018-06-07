//
//  JJCWechatRequestManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWechatRequestManager.h"
#import "JJCWechatResponseManager.h"
#import "JJCThirdPlatformModel.h"
#import "UIImage+scale.h"
#import <WXApi.h>

static NSString *kAuthScope = @"snsapi_userinfo";

@implementation JJCWechatRequestManager
//登录
+(BOOL)sendAuthInViewController:(id)viewController{
    SendAuthReq* request = [[SendAuthReq alloc] init];
    NSString* kAuthState = [NSString stringWithFormat:@"com.xiudou.xiudouiOS//%d",(arc4random() % 1000000) + 1];
    request.scope = kAuthScope;
    request.state = kAuthState;
    return [WXApi sendAuthReq:request viewController:viewController delegate:[JJCWechatResponseManager sharedInstance]];
}
//支付
+ (BOOL)payWithOrder:(JJCOrderModel *)order {
    //调起微信支付
    PayReq* req     = [[PayReq alloc] init];
    req.prepayId    = order.prepayid;
    req.partnerId   = order.partnerid;
    req.nonceStr    = order.noncestr;
    req.timeStamp   = order.timestamp;
    req.package     = order.package;
    req.sign        = order.sign;
    BOOL result     = [WXApi sendReq:req];
    return result;
}
//分享
+(BOOL)sendMessageWithModel:(JJCThirdPlatformShareModel *)model{
    enum WXScene wxScene = 0;
    if(JJCShareTypeWechat == model.platform){
        wxScene = WXSceneSession;
    }else if (JJCShareTypeWechatLine == model.platform){
        wxScene = WXSceneTimeline;
    }
    SendMessageToWXReq* request = [[SendMessageToWXReq alloc] init];
    request.scene = wxScene;
    request.bText = NO;
    WXMediaMessage* msg = [[WXMediaMessage alloc] init];
    msg.title = model.title;
    msg.description = model.text;
    [msg setThumbImage:[UIImage thumbImageWithOrgImage:model.image]];
    if(model.mediaObject.contentType == JJCShareContentTypeImage){//图片
        WXImageObject* obj = [WXImageObject object];
        NSInteger maxSharedImageBytes = 10*1024*1024;//10M
        NSData* imageData = UIImageJPEGRepresentation([UIImage scaleImageWithOrgImage:model.image maxBytes:maxSharedImageBytes], 1.0);
        obj.imageData = imageData;
        msg.mediaObject = obj;
    }else if(model.mediaObject.contentType == JJCShareContentTypeVideo){//视频
        WXVideoObject* obj = [WXVideoObject object];
        obj.videoUrl = model.urlString;
        msg.mediaObject = obj;
    }else{//网页
        WXWebpageObject* obj = [WXWebpageObject object];
        obj.webpageUrl = model.urlString;
        msg.mediaObject = obj;
    }
    request.message = msg;
    return [WXApi sendReq:request];
}
@end
