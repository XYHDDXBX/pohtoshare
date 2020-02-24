//
//  XYHHttpTool.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHHttpTool : NSObject

+(void)XYH_GET:(NSString *)URLString
 parameters:(id __nullable)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


+(void)XYH_POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
