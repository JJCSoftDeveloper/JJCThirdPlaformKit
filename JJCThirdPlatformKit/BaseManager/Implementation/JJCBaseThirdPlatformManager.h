//
//  JJCBaseThirdPlatformManager.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/14.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCThirdPlatformHandler.h"

@class JJCThirdPlatformShareModel;

@interface JJCBaseThirdPlatformManager : NSObject<JJCThirdPlatformHandler>
@property (nonatomic,copy  ) JJC_SignInResultBlock signInResultBlock;
@property (nonatomic,copy  ) JJC_PaymentResultBlock paymentResultBlock;
@property (nonatomic,copy  ) JJC_ShareResultBlock shareResultBlock;

// 第三方分享，子类重写该方法
-(void)doShareWithModel:(JJCThirdPlatformShareModel*)model;
@end
