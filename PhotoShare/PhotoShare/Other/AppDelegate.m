//
//  AppDelegate.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootVC = [[XYHTabBarVC alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    //添加一个系统通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //初始化
   Reachability *internetReachability=[Reachability reachabilityForInternetConnection];
    //通知添加到Run Loop
    [internetReachability startNotifier];
    [self updateInterfaceWithReachability:internetReachability];
    
    
    return YES;
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        NSLog(@"====当前网络状态不可用=======");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前网络状态不可用" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了按钮");
        }]];
        
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
        
    }else if (netStatus ==ReachableViaWiFi ){
        NSLog(@"====当前网络状态为Wifi=======");
    }else if (netStatus == ReachableViaWWAN){
        NSLog(@"====当前网络状态为流量=======keso");
    }
}

@end
