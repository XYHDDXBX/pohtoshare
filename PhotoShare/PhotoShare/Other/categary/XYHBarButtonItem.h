//
//  XYHBarButtonItem.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYHBarButtonItem : UIBarButtonItem
+(UIBarButtonItem *)itemWithImage:(NSString *)image seletedImage:(NSString *)seleImage target:(id)target action:(SEL)action;
@end
