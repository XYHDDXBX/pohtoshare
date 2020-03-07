//
//  XYHProfileVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHProfileVC.h"
#import "XYHBarButtonItem.h"
#import "UIColor+XYHColor.h"
#import "XYHLoginVC.h"
#import "XYHUserModel.h"
#import "XYHFMDBTool.h"
#import "XYHSetingVC.h"
#import "XYHImage.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width*1.0
@interface XYHProfileVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidthConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upConstrain;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) XYHUserModel  *userModel;

@end

@implementation XYHProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self judgeUserState];
}

-(void)judgeUserState{
    XYHUserModel *userM = [XYHFMDBTool userWithSQL:@"select * from t_userinfo"];
    self.userModel = userM;
    if (userM.state) {
        NSLog(@"登录状态");
        self.btnWidthConstrain.constant = 130;
        self.upConstrain.constant = 27.5;
        UIImage *iconImage = [XYHImage Base64StrToUIImage:userM.iconImage];
        [self.loginBtn setImage:iconImage forState:UIControlStateNormal];
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.width/2;
        self.loginBtn.clipsToBounds  =YES;
        self.nickName.text = userM.username;
        self.bottomView.backgroundColor = [UIColor clearColor];
        self.nickName.hidden = NO;
        self.loginBtn.userInteractionEnabled = NO;
        
    }else{
        NSLog(@"未登录状态");
        self.nickName.hidden = YES;
        self.loginBtn.userInteractionEnabled = YES;
        self.loginBtn.layer.cornerRadius = 0;
        self.loginBtn.clipsToBounds = NO;
        self.btnWidthConstrain.constant = 45;
        self.upConstrain.constant = 70;
        [self.loginBtn setImage:[UIImage imageNamed:@"my-btn-6"] forState:UIControlStateNormal];
        [self.loginBtn setImage:[UIImage imageNamed:@"my-btn-pre-6"] forState:UIControlStateHighlighted];
    }
}

-(void)setupUI{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 44;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.bounces = NO;
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"我的";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
    self.navigationItem.rightBarButtonItem = [XYHBarButtonItem itemWithImage:@"my-btn-pre-5" seletedImage:@"my-btn-5" target:self action:@selector(setting)];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIView *uplineView = [[UIView alloc] initWithFrame:CGRectMake(0, 92, kScreenW, 1)];
    uplineView.backgroundColor = [UIColor blackColor];
    uplineView.alpha = 0.2;
    [self.bottomView addSubview:uplineView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myID = @"myID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myID];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"my-icon-1"];
        cell.textLabel.text = @"我的发布";
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"my-icon-2"];
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"my-icon-3"];
        cell.textLabel.text = @"我的偏好";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"my-icon-4"];
        cell.textLabel.text = @"邀请好友";
    }
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my-btn-7"]];
    imageV.frame = CGRectMake(kScreenW-14, 16, 8, 12);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kScreenW, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [cell.contentView addSubview:lineView];
    [cell.contentView addSubview:imageV];
    cell.textLabel.textColor = [UIColor colorWithRGBHex:0x999999];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)setting{
    NSLog(@"点击了设置");
    XYHSetingVC *setVC = [[XYHSetingVC alloc] init];
    setVC.userM =self.userModel;
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void)login{
    XYHLoginVC *loginvc = [[XYHLoginVC alloc] init];
    [self.navigationController pushViewController:loginvc animated:YES];
}



@end
