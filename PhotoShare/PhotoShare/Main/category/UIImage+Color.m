//
//  UIImage+Color.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)


+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
