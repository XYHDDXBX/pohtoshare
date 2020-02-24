//
//  XYHFMDBTool.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHFMDBTool : NSObject

//保存模型数组
+(void)saveWithPhotoList:(NSArray *)photoArray;

//取模型
+(NSArray *)photoListWithSQL:(NSString *)sql;



@end

NS_ASSUME_NONNULL_END
