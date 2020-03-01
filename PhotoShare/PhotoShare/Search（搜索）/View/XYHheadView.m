//
//  XYHheadView.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/26.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHheadView.h"

@interface XYHheadView() 

@end

@implementation XYHheadView

+(instancetype)headView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XYHheadView class]) owner:nil options:nil] firstObject];
}

@end
