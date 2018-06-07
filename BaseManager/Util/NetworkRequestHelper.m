//
//  NetworkRequestHelper.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/22.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "NetworkRequestHelper.h"

@implementation NetworkRequestHelper
+ (void)requestWithURLString:(NSString*_Nullable)urlString  completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    if(!urlString||[urlString isEqualToString:@""]){
        NSLog(@"请求路径不能为空或者空字符串");
        return;
    }
    NSURL* url = [NSURL URLWithString:urlString];
    if(!url){
        NSLog(@"请求路径有误，请确认。");
        return;
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
}
@end
