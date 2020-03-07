//
//  XYHImage.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHImage : NSObject

+(NSString *)UIImageToBase64Str:(UIImage *)image;

+(UIImage *)Base64StrToUIImage:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
