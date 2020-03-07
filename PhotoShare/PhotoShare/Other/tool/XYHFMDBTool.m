//
//  XYHFMDBTool.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHFMDBTool.h"
#import <FMDB.h>
#import "photolistModel.h"
#import "MJExtension.h"
#import "XYHUserModel.h"
@implementation XYHFMDBTool
static  FMDatabase *_db;

//初始化
+(void)initialize
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachePath=[path stringByAppendingPathComponent:@"photolist.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:cachePath];
    BOOL flag= [db open];
    _db=db;
    if (flag){
        NSLog(@"数据库打开成功");
    }else{
       NSLog(@"数据库打开失败");
    }
    
    //创建表格1:联系人
    BOOL flag1= [db executeUpdate:@"create table if not exists t_photolist (id integer primary key autoincrement, dict blob);"];
     if (flag1){
         NSLog(@"创建图片表格成功");
     }else{
         NSLog(@"创建图片表格失败");
     }
    
    //创建表格2:用户
    BOOL flag2= [db executeUpdate:@"create table if not exists t_userinfo (id integer primary key autoincrement, user blob);"];
    if (flag2){
        NSLog(@"创建用户表格成功");
    }else{
        NSLog(@"创建用户表格失败");
    }

}

+(void)saveWithPhotoList:(NSArray *)photoArray{
    for (photolistModel *model in photoArray) {
        NSData *data = [self dataFromModel:model];
        BOOL flag = [_db executeUpdate:@"insert into t_photolist (dict) values(?)",data];
        if (flag) {
            NSLog(@"图片列表保存成功");
        }else{
            NSLog(@"图片列表保存失败");
        }
    }
}

+(NSArray *)photoListWithSQL:(NSString *)sql{
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        photolistModel *model = [self modelFromData:data];
        [array addObject:model];
    }
    return array;
}

//保存用户模型
+(void)saveWithUser:(XYHUserModel *)userM{
    NSDictionary *dict=userM.mj_keyValues;
    NSData *data=[NSKeyedArchiver  archivedDataWithRootObject:dict];
        BOOL flag = [_db executeUpdate:@"insert into t_userinfo (user) values(?)",data];
        if (flag) {
            NSLog(@"用户列表保存成功");
        }else{
            NSLog(@"用户列表保存失败");
        }
}

//取用户模型
+(XYHUserModel *)userWithSQL:(NSString *)sql{
    FMResultSet *set = [_db executeQuery:sql];
    XYHUserModel *userModel = [[XYHUserModel alloc] init];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"user"];
        NSDictionary *modelDict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        XYHUserModel *model=[ XYHUserModel mj_objectWithKeyValues:modelDict];
        userModel = model;
    }
    return userModel;
}

//修改用户模型的state
+(void)updateWithUserstate:(NSData *)state OriginalState:(NSData *)originalState{
    BOOL flag = [_db executeUpdate:@"update t_userinfo  set  user=? where user=? ",state,originalState];
    if (flag) {
        NSLog(@"状态修改成功");
    }else{
        NSLog(@"状态修改失败");
    }
    
}

//模型转data
+(NSData *)dataFromModel:(photolistModel *)model
{
    NSDictionary *dict=model.mj_keyValues;
    NSData *data=[NSKeyedArchiver  archivedDataWithRootObject:dict];
    return data;
}

//data转模型
+ (photolistModel *)modelFromData:(NSData *)data
{
    NSDictionary *modelDict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    photolistModel *model=[ photolistModel mj_objectWithKeyValues:modelDict];
    return model;
}

@end
