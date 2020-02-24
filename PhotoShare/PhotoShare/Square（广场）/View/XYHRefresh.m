//
//  XYHRefresh.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/22.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHRefresh.h"

@interface XYHRefresh ()



@end

@implementation XYHRefresh

+ (instancetype)refresh{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XYHRefresh class]) owner:nil options:nil] firstObject];
}

@end
