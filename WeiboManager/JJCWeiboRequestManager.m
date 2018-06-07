//
//  JJCWeiboRequestManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCWeiboRequestManager.h"
#import "JJCThirdPlatformManager.h"
#import "JJCThirdPlatformModel.h"
#import "UIImage+scale.h"
@implementation JJCWeiboRequestManager
+(BOOL)sendAuthInViewController:(id)viewController{
    WBAuthorizeRequest* request = [WBAuthorizeRequest request];
    NSString* redirectURL = [[JJCThirdPlatformManager sharedInstance] appIDWithPlaform:JJCThirdPlatformTypeWeibo];
    request.redirectURI = redirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}
+(BOOL)sendMessageWithModel:(JJCThirdPlatformShareModel *)model{
    WBMessageObject* msg = [WBMessageObject message];
    msg.text = [NSString stringWithFormat:@"%@ %@",model.weiboText,model.urlString];
    WBImageObject* imageObj = [WBImageObject object];
    NSInteger maxSharedImageBytes = 10*1024*1024;//10M
    NSData* imageData = UIImageJPEGRepresentation([UIImage scaleImageWithOrgImage:model.image maxBytes:maxSharedImageBytes], 1.0);
    imageObj.imageData = imageData;
    msg.imageObject = imageObj;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

@end
