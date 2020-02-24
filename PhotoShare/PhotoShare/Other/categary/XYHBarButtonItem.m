//
//  XYHBarButtonItem.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import "XYHBarButtonItem.h"

@implementation XYHBarButtonItem

+(UIBarButtonItem *)itemWithImage:(NSString *)image seletedImage:(NSString *)seleImage target:(id)target action:(SEL)action{
    UIButton*button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:seleImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
