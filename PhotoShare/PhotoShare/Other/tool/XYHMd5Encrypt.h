//
//  XYHMd5Encrypt.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/3.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
NS_ASSUME_NONNULL_BEGIN

@interface XYHMd5Encrypt : NSObject

+ (NSString *)MD5ForLower32Bate:(NSString *)str;

+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

+ (NSString *)MD5ForUpper16Bate:(NSString *)str;

+ (NSString *)MD5ForLower16Bate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
