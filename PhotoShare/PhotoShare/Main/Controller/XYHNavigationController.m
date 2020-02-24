//
//  XYHNavigationController.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import "XYHNavigationController.h"
#import "XYHBarButtonItem.h"
#import "UIImage+Color.h"
@interface XYHNavigationController ()

@end

@implementation XYHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏的背景颜色
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(102)/255.0 green:(124)/255.0 blue:(137)/255.0 alpha:(255)/255.0]] forBarMetrics:UIBarMetricsDefault];
}

+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self,nil];
    
}

//进入二级控制器的时候隐藏tabbar同时设置返回navgationbar的左右按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {

self.navigationItem.leftBarButtonItem = [XYHBarButtonItem itemWithImage:@"back" seletedImage:@"back" target:self action:@selector(back)];

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
    
}







@end
