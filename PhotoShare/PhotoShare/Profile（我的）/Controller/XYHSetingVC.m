//
//  XYHSetingVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHSetingVC.h"
#import "XYHBarButtonItem.h"
#import "UIColor+XYHColor.h"
#import "XYHUserModel.h"
#import "XYHFMDBTool.h"
#import "MJExtension.h"
#import "XYHfeedBackVC.h"
#import "XYHQuitPopVC.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width*1.0
@interface XYHSetingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *setTablevView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel  *cacheLabel;

@end

@implementation XYHSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSetTableView];
    
//    [self clearFile];
//
//    NSString *path1 = [self getCachesPath];
//    float cache1 = [self folderSizeAtPath:path1];
//    NSString *cacheStr1 = [NSString stringWithFormat:@"%0.2f",cache1];
//    NSLog(@"cache = %@",cacheStr1);
}



-(void)setupSetTableView{
    self.setTablevView.rowHeight = 44;
    self.setTablevView.showsVerticalScrollIndicator = NO;
    self.setTablevView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.setTablevView.bounces = NO;
    self.setTablevView.delegate = self;
    self.setTablevView.dataSource = self;
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"设置";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
    self.navigationItem.leftBarButtonItem = [XYHBarButtonItem itemWithImage:@"back-1" seletedImage:@"back-pre-1" target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)logout:(UIButton *)sender {
    XYHQuitPopVC *popVC = [[XYHQuitPopVC alloc] init];
    popVC.providesPresentationContextTransitionStyle = YES;
    popVC.definesPresentationContext = YES;
    popVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    popVC.type = TypeQuit;
    [self presentViewController:popVC animated:NO completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *setID = @"setID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setID];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my-btn-7"]];
    imageV.frame = CGRectMake(kScreenW-14, 16, 8, 12);
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:setID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改用户名";
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-165, 12, 120, 20.33)];
        self.nameLabel.textColor = [UIColor colorWithRGBHex:0x999999];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        if (self.userM.state) {
            self.nameLabel.text = self.userM.username;
        }else{
            self.nameLabel.text = @"";
        }
        [cell.contentView addSubview:self.nameLabel];
        [cell.contentView addSubview:imageV];
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"意见反馈";
        [cell.contentView addSubview:imageV];
    }else if (indexPath.row == 2){
        UIButton *savebtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW-45, 8, 38, 28)];
        [savebtn setImage:[UIImage imageNamed:@"setting-btn-2"] forState:UIControlStateNormal];
        [savebtn setImage:[UIImage imageNamed:@"setting-btn-pre-2"] forState:UIControlStateSelected];
        [savebtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.textLabel.text = @"保存原始图片";
        [cell.contentView addSubview:savebtn];
    }else{
        cell.textLabel.text = @"清除缓存";
        self.cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-154, 12, 120, 20.33)];
        self.cacheLabel.textColor = [UIColor colorWithRGBHex:0x999999];
        self.cacheLabel.textAlignment = NSTextAlignmentRight;
        NSString *path = [self getCachesPath];
        float cache = [self folderSizeAtPath:path];
        NSString *cacheStr = [NSString stringWithFormat:@"%0.2f",cache];
        self.cacheLabel.text = [cacheStr stringByAppendingString:@"MB"];
        [cell.contentView addSubview:self.cacheLabel];
        [cell.contentView addSubview:imageV];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kScreenW, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [cell.contentView addSubview:lineView];
    cell.textLabel.textColor = [UIColor colorWithRGBHex:0x999999];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)buttonClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if(self.userM.state){
            [self reviseUsername];
        }
    }else if(indexPath.row == 1){
        XYHfeedBackVC *feedback = [[XYHfeedBackVC alloc] init];
        [self.navigationController pushViewController:feedback animated:YES];
    }else if (indexPath.row == 3){
        XYHQuitPopVC *popVC = [[XYHQuitPopVC alloc] init];
        popVC.providesPresentationContextTransitionStyle = YES;
        popVC.definesPresentationContext = YES;
        popVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        popVC.type = TypeClean;
        popVC.block = ^(BOOL text) {
            if (text) {
                self.cacheLabel.text = @"0.00MB";
            };
        };
        [self presentViewController:popVC animated:NO completion:nil];
    }
}

-(void)reviseUsername{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请输入你的新昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
           [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
               textField.placeholder = @"新昵称";
               textField.textColor = [UIColor colorWithRGBHex:0xacacac];
               textField.tintColor = [UIColor colorWithRGBHex:0xacacac];
           }];
           UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认修改" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
               XYHUserModel *userM = [XYHFMDBTool userWithSQL:@"select * from t_userinfo"];
               NSDictionary *dict=userM.mj_keyValues;
               NSData *oriData=[NSKeyedArchiver  archivedDataWithRootObject:dict];
               NSString *newName = [[alertVc textFields] objectAtIndex:0].text;
               self.userM.username = newName;
               NSDictionary *dict1=self.userM.mj_keyValues;
               NSData *data=[NSKeyedArchiver  archivedDataWithRootObject:dict1];
               [XYHFMDBTool updateWithUserstate:data OriginalState:oriData];
               [self dismissViewControllerAnimated:YES completion:^{
                   self.nameLabel.text = nil;
                   [self.setTablevView reloadData];
               }];
           }];
           UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
           [alertVc addAction:action2];
           [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
}


//获取缓存文件路径
-(NSString *)getCachesPath{
  //获取Caches目录路径
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
  NSString *cachesDir = [paths objectAtIndex:0];
  NSString *filePath = [cachesDir stringByAppendingPathComponent:@"www.netease.com.PhotoShare"];
  return filePath;
}

//显示缓存大小
-(float)filePath{
    //获取cache目录
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) firstObject];
    return [self folderSizeAtPath :cachPath];
}

//首先我们计算一下 单个文件的大小
- (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0 ;
}

//遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- (float) folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0 * 1024.0);
}

@end
