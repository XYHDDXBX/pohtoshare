//
//  UIBarButtonItem+XYHBarButtonIterm.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (XYHBarButtonIterm)
+(UIBarButtonItem *)ItemWithImage:(NSString *)image seleImage:(NSString *)selImage target:(id)target action:(SEL)action;

//返回按钮
+(UIBarButtonItem *) itenWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action andTitle:(NSString *) title;

//仅添加文字
+(UIBarButtonItem *) itemWithTitle:(NSString *) title addTarget:(id)target action:(SEL)action;
@end
