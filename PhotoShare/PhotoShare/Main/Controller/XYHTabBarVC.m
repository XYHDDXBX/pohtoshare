//
//  XYHTabBarVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020年 yuhangxi. All rights reserved.
//

#import "XYHTabBarVC.h"
#import "XYHNavigationController.h"

@interface XYHTabBarVC ()<UITabBarControllerDelegate>


@end

@implementation XYHTabBarVC


-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate=self;
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:(255)/255.0 green:(255)/255.0 blue:(255)/255.0 alpha:(255)/255.0]];
    self.tabBar.tintColor = [UIColor colorWithRed:(102)/255.0 green:(124)/255.0 blue:(137)/255.0 alpha:(255)/255.0];
   
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIViewController *square = [self addViewControllerWithClass:[XYHSquareVC class] title:@"广场" Image:@"btn-1" SeleImage:@"btn-pre-1"];
        UIViewController *search = [self addViewControllerWithClass:[XYHSearchVC class] title:@"搜索" Image:@"btn-2" SeleImage:@"btn-pre-2"];
        UIViewController *photo = [self addViewControllerWithClass:[XYHPhotoVC class] title:@"发图" Image:@"btn-3" SeleImage:@"btn-pre-3"];
        UIViewController *profile = [self addViewControllerWithClass:[XYHProfileVC class] title:@"我的" Image:@"btn-4" SeleImage:@"btn-pre-4"];
        self.viewControllers = @[square,search,photo,profile ];

    }
    return self;
}

//根据一个类创建一个控制器(带图片)
-(UIViewController *)addViewControllerWithClass:(Class)class title:(NSString *)title Image:(NSString *)image SeleImage:(NSString *)selImage{
    UIViewController *vc = [[class alloc] init];
    return [self addViewContrillerWithVC:vc title:title Image:image SeleImage:selImage];
}

//根据一个创建好的控制器初始化控制器(带图片)
-(UIViewController *)addViewContrillerWithVC:(UIViewController *)VC title:(NSString *)title Image:(NSString *)image SeleImage:(NSString *)selImage{
    VC.tabBarItem.title = title;
//    VC.navigationController.navigationBar.translucent = YES;
    //底部的图片
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:(102)/255.0 green:(124)/255.0 blue:(137)/255.0 alpha:(255)/255.0]} forState:UIControlStateSelected];
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:(211)/255.0 green:(211)/255.0 blue:(211)/255.0 alpha:(255)/255.0]} forState:UIControlStateNormal];
    
    XYHNavigationController *nav = [[XYHNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    return nav;
}

@end
