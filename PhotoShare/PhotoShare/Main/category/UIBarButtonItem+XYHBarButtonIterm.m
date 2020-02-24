//
//  UIBarButtonItem+XYHBarButtonIterm.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import "UIBarButtonItem+XYHBarButtonIterm.h"

@implementation UIBarButtonItem (XYHBarButtonIterm)
+(UIBarButtonItem *)ItemWithImage:(NSString *)image seleImage:(NSString *)selImage target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImage] forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:btn ];
}

+(UIBarButtonItem *) itenWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action andTitle:(NSString *) title
{
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton setTitle:title forState: UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    //button属性左移
    backButton.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

+(UIBarButtonItem *) itemWithTitle:(NSString *) title addTarget:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState: UIControlStateNormal];

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

    
}
@end
