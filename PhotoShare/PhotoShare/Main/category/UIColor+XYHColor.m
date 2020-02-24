//
//  UIColor+XYHColor.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/18.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "UIColor+XYHColor.h"




@implementation UIColor (XYHColor)

+(UIColor *)colorWithRGBHex:(UInt32)hex{
    int r = (hex >> 16) & 0xFF;
        int g = (hex >> 8) & 0xFF;
        int b = (hex) & 0xFF;

        return [UIColor colorWithRed:r / 255.0f
                               green:g / 255.0f
                                blue:b / 255.0f
                               alpha:1.0f];
}

@end
