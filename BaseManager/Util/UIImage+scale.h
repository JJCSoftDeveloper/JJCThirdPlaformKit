//
//  UIImage+scale.h
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/22.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scale)
-(UIImage*)imageWithNewScale:(float)scaleSize;
+(UIImage*)scaleImageWithOrgImage:(UIImage*)orgImage maxBytes:(NSInteger)maxBytes;
+(UIImage*)thumbImageWithOrgImage:(UIImage*)orgImage;
@end
