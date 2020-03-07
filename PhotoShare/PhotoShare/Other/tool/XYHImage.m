//
//  XYHImage.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHImage.h"

@implementation XYHImage

//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *)image{
NSData *data = UIImageJPEGRepresentation(image, 1.0f);
NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
return imageStr;
}

//字符串转图片
+(UIImage *)Base64StrToUIImage:(NSString *)imageStr{
NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
UIImage *image = [UIImage imageWithData:imageData];
return image;
}


@end
