//
//  XYHQuitPopVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHQuitPopVC.h"
#import "XYHFMDBTool.h"
#import "XYHUserModel.h"
#import "MJExtension.h"

@interface XYHQuitPopVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrain;
@property (weak, nonatomic) IBOutlet UIButton *surequitBtn;


@end

@implementation XYHQuitPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
    if (self.type == TypeQuit) {//退出
        [self.surequitBtn setImage:[UIImage imageNamed:@"quit-btn-pre-3"] forState:UIControlStateNormal];
        [self.surequitBtn setImage:[UIImage imageNamed:@"quit-btn-3"] forState:UIControlStateHighlighted];
    }else if(self.type == TypeClean){//清除
        [self.surequitBtn setImage:[UIImage imageNamed:@"quit-btn-pre-1"] forState:UIControlStateNormal];
        [self.surequitBtn setImage:[UIImage imageNamed:@"quit-btn-1"] forState:UIControlStateHighlighted];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
       self.bottomConstrain.constant = 0;
       [UIView animateWithDuration:0.25 animations:^{
           [self.view layoutIfNeeded];
       }];
}

- (IBAction)sureQuit:(UIButton *)sender {
    if (self.type == TypeQuit) {//退出
        XYHUserModel *userM = [XYHFMDBTool userWithSQL:@"select * from t_userinfo"];
        NSDictionary *dict = userM.mj_keyValues;
        NSData *oriData=[NSKeyedArchiver  archivedDataWithRootObject:dict];
        userM.state = NO;
        NSDictionary *dict1=userM.mj_keyValues;
        NSData *data=[NSKeyedArchiver  archivedDataWithRootObject:dict1];
        [XYHFMDBTool updateWithUserstate:data OriginalState:oriData];
        [self dismissViewControllerAnimated:NO completion:nil];
    }else if(self.type == TypeClean){//清除
//        [self clearFile];
    }
}

- (IBAction)cancle:(UIButton *)sender {
    self.bottomConstrain.constant = -93;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

//获取缓存文件路径
-(NSString *)getCachesPath{
  //获取Caches目录路径
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
  NSString *cachesDir = [paths objectAtIndex:0];
  NSString *filePath = [cachesDir stringByAppendingPathComponent:@"www.netease.com.PhotoShare"];
  return filePath;
}

// 清理缓存
- (void)clearFile{
    NSString *cachPath = [self getCachesPath];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath :cachPath];
    for (NSString *p in files) {
        NSError *error = nil;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error :&error];
        }
    }
    [self performSelectorOnMainThread:@selector(clearCachSuccess) withObject:nil waitUntilDone:YES];
}

-(void)clearCachSuccess{
    if (self.block) {
        self.block(YES);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
