//
//  JJCBaseThirdPlatformManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/14.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformManager.h"
#import <SDWebImage/SDWebImageManager.h>
#import "JJCThirdPlatformModel.h"

@implementation JJCBaseThirdPlatformManager
-(void)thirdPlatConfigWithApplication:(id)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSAssert(YES,@"实现app启动后第三方所需逻辑");
}
/**
 第三方平台处理URL
 */
-(BOOL)thirdPlatCanOpenUrlWithApplication:(id)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 子类实现
    NSAssert(YES, @"第三方处理URL逻辑实现");
    return NO;
}
/**
 第三方分享
 */
-(void)shareWithModel:(JJCThirdPlatformShareModel *)model{
    __block UIImage* sharedImage = nil;
    if(model.image){
        [self doShareWithModel:model];
    }else if(model.imageUrlString != nil&&[model.imageUrlString isKindOfClass:[NSString class]]){
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:model.imageUrlString] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if(image){
                sharedImage = image;
            }else{
                sharedImage = [UIImage imageNamed:@"app_icon"];
            }
            model.image = sharedImage;
            [self doShareWithModel:model];
        }];
    }else{
        sharedImage = [UIImage imageNamed:@"app_icon"];
        model.image = sharedImage;
        [self doShareWithModel:model];
    }
}
-(void)doShareWithModel:(JJCThirdPlatformShareModel *)model{
    // 空实现，子类实现该方法
}
/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(JJCThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(JJC_SignInResultBlock)callback {
    // 空实现，子类实现该方法
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(JJCThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(JJC_PaymentResultBlock)paymentBlock {
    // 空实现，子类实现该方法
}

#pragma mark - ......::::::: JJCThirdPlatformRespManagerDelegate :::::::......

- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(JJCThirdPlatformType)platform {
    JJCThirdPlatformOnMainThreadAsync(^{
        !self.signInResultBlock ?: self.signInResultBlock(response, nil);
    });
}

- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(JJCShareType)platform {
    JJCThirdPlatformOnMainThreadAsync(^{
        if (result) {
            !self.shareResultBlock ?: self.shareResultBlock(platform, JJCShareResultSuccess, nil);
        } else {
            !self.shareResultBlock ?: self.shareResultBlock(platform, JJCShareResultFailed, nil);
        }
    });
}

- (void)respManagerDidRecvPayResponse:(BOOL)result platform:(JJCThirdPlatformType)platform {
    JJCThirdPlatformOnMainThreadAsync(^{
        !self.paymentResultBlock ?: self.paymentResultBlock(platform, result);
    });
}

// APP是否安装
- (BOOL)isAppInstalled {
    return YES;
}
@end
