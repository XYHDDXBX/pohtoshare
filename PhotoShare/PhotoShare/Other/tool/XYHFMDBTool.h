//
//  XYHFMDBTool.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYHUserModel;
@class photolistModel;
NS_ASSUME_NONNULL_BEGIN

@interface XYHFMDBTool : NSObject

//保存模型数组
+(void)saveWithPhotoList:(NSArray *)photoArray;

//取模型
+(NSArray *)photoListWithSQL:(NSString *)sql;

//删除图片
+(void)deleatWithPhotoListModel:(NSData *)ID;


//保存模型数组
+(void)saveWithUser:(XYHUserModel *)userM;

//取模型
+(XYHUserModel *)userWithSQL:(NSString *)sql;

//改状态
+(void)updateWithUserstate:(NSData *)state OriginalState:(NSData *)originalState;

+(NSData *)dataFromModel:(photolistModel *)model;

@end

NS_ASSUME_NONNULL_END
