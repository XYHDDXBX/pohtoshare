//
//  XYHUserPhotoVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/7.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHUserPhotoVC.h"
#import "SquareCell.h"
#import "XYHBarButtonItem.h"
#import "XYHFMDBTool.h"
#import "photolistModel.h"
#import "UIColor+XYHColor.h"
#import "XYHPhotoDeatilVC.h"
@interface XYHUserPhotoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *tableview;
@property (strong, nonatomic) NSMutableArray  *userPhotoListArr;
@end

@implementation XYHUserPhotoVC
static NSString *ID = @"cell";

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([SquareCell class]) bundle:nil] forCellReuseIdentifier:ID];
        _tableview.rowHeight = 217;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableview;
}

- (NSMutableArray *)userPhotoListArr{
    if (!_userPhotoListArr) {
        _userPhotoListArr = [NSMutableArray array];
    }
    return _userPhotoListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userPhotoListArr removeAllObjects];
    NSArray *photolisrArray = [XYHFMDBTool photoListWithSQL:@"select * from t_photolist"];
    for (photolistModel *model in photolisrArray) {
        if (model.favorite == 1) {
            [self.userPhotoListArr addObject:model];
        }
    }
    [self.tableview reloadData];
}

-(void)setupUI{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"我的发布";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
    lable.frame = CGRectMake(0, 1, 60, 40);
    self.navigationItem.leftBarButtonItem = [XYHBarButtonItem itemWithImage:@"back-1" seletedImage:@"back-pre-1" target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userPhotoListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SquareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SquareCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.photolistModel = self.userPhotoListArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SquareCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [[UIView alloc] initWithFrame:cell.bgView.bounds];
    view.backgroundColor = [UIColor colorWithRGBHex:0x000000];
    view.alpha = 0.3;
    [cell.bgView addSubview:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = YES;
        XYHPhotoDeatilVC *detailvc = [[XYHPhotoDeatilVC alloc] init];
        [self.navigationController pushViewController:detailvc animated:YES];
        detailvc.detailModel = cell.photolistModel;
        detailvc.isUserDetailPhoto = YES;
    });
}


@end
