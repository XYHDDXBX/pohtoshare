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
#define kScreenW [UIScreen mainScreen].bounds.size.width*1.0
@interface XYHProfileVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation XYHProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
    return cell;
}


-(void)setting{
    NSLog(@"点击了设置");
    
}





@end
