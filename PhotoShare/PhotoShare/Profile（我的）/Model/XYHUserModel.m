//
//  XYHUserModel.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/3.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHUserModel.h"

@implementation XYHUserModel

-(instancetype)initWithEmail:(NSString *)email password:(NSString *)password state:(BOOL )state username:(NSString *)username iconImage:(NSString *)iconimage{
    if (self = [super init]) {
        self.email = email;
        self.password = password;
        self.state = NO;
        self.username = username;
        self.iconImage = iconimage;
    }
    return self;
}

+(instancetype)modelWithEmail:(NSString *)email password:(NSString *)password state:(BOOL )state username:(NSString *)username iconImage:(NSString *)iconimage{
    return [[self alloc] initWithEmail:email password:password state:state username:username iconImage:iconimage];
}

@end
