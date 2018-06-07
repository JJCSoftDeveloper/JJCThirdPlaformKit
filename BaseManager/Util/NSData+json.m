//
//  NSData+json.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/22.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "NSData+json.h"

@implementation NSData (json)
-(id)jsonObject{
    NSError* error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"data convert json error : %@",error);
    }
    return obj;
}
@end
