//
//  UIImage+scale.m
//  JJCThirdPlatformKit
//
//  Created by jjc on 2018/5/22.
//  Copyright © 2018年 jjc. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)
-(UIImage*)imageWithNewScale:(float)scaleSize{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*scaleSize, self.size.height*scaleSize), NO, 1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width*scaleSize, self.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+(UIImage*)thumbImageWithOrgImage:(UIImage*)orgImage{
    NSInteger maxSharedImageBytes = 32*1000;//32K
    return [self scaleImageWithOrgImage:orgImage maxBytes:maxSharedImageBytes];
}
+(UIImage*)scaleImageWithOrgImage:(UIImage*)orgImage maxBytes:(NSInteger)maxBytes{
    NSInteger orgImageBytes = UIImageJPEGRepresentation(orgImage, 1.0).length;
    if(orgImageBytes>maxBytes){
        CGFloat scale = maxBytes*1.0/orgImageBytes;
        UIImage* scaledImage = [orgImage imageWithNewScale:scale];
        if(scaledImage){
            return scaledImage;
        }
    }
    return orgImage;
}
@end
