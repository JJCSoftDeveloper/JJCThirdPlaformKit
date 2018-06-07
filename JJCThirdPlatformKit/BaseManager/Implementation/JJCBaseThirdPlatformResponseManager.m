//
//  JJCBaseThirdPlatformResponseManager.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/15.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "JJCBaseThirdPlatformResponseManager.h"
@interface JJCBaseThirdPlatformResponseManager(){
    __weak id<JJCThirdPlatformResponseHandlerDelegate> _delegate;
}
@end
@implementation JJCBaseThirdPlatformResponseManager

- (void)setDelegate:(id<JJCThirdPlatformResponseHandlerDelegate>)delegate {
    _delegate = delegate;
}

- (id<JJCThirdPlatformResponseHandlerDelegate>)delegate {
    return _delegate;
}
@end
