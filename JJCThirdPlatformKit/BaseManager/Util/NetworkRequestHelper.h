//
//  NetworkRequestHelper.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/22.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestHelper : NSObject
+ (void)requestWithURLString:(NSString*_Nullable)urlString  completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
@end
