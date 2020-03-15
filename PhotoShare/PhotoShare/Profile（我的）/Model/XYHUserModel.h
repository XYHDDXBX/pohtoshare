//
//  XYHUserModel.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/3.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHUserModel : NSObject

@property (strong, nonatomic) NSString  *email;

//@property (strong, nonatomic) NSString  *password;

@property(nonatomic,assign) BOOL state;

@property (strong, nonatomic) NSString  *username;

@property (strong, nonatomic) NSString  *iconImage;

//提供构造方法
-(instancetype)initWithEmail:(NSString *)email state:(BOOL )state username:(NSString *)username iconImage:(NSString *)iconimage;

+(instancetype)modelWithEmail:(NSString *)email state:(BOOL)state username:(NSString *)username iconImage:(NSString *)iconimage;


@end

NS_ASSUME_NONNULL_END
