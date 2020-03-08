//
//  XYHSquareVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHSquareVC.h"
#import "SquareCell.h"
#import "UIColor+XYHColor.h"
#import "XYHHttpTool.h"
#import "photolistModel.h"
#import "MJExtension.h"
#import "XYHFMDBTool.h"
#import "XYHPhotoDeatilVC.h"
#import "XYHRefresh.h"
@interface XYHSquareVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView  *tableview;
@property (strong, nonatomic) NSMutableArray  *photolistArray;
@property (strong, nonatomic) UIRefreshControl  *refreshC;
@end

@implementation XYHSquareVC

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

- (NSMutableArray *)photolistArray{
    if (!_photolistArray) {
        _photolistArray = [NSMutableArray array];
    }
    return _photolistArray;
}

- (UIRefreshControl *)refreshC{
    if (!_refreshC) {
        _refreshC = [[UIRefreshControl alloc] init];
        UIView *refreshView = [XYHRefresh refresh];
        refreshView.backgroundColor = [UIColor colorWithRGBHex:0xe7e7e7];
        [_refreshC addSubview: refreshView];
        _refreshC.backgroundColor = [UIColor redColor];
        [_refreshC addTarget:self action:@selector(refreshandel:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshC;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *photolisrArray = [XYHFMDBTool photoListWithSQL:@"select * from t_photolist"];
    if(photolisrArray.count){
        self.photolistArray = (NSMutableArray *)photolisrArray;
        [self.tableview reloadData];
    }else{
        [self loadPhotolist];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.refreshControl = self.refreshC;
    [self.view addSubview:self.tableview];
}

/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"%d",self.refreshC.refreshing);
    XYHRefresh *refreshView =  self.refreshC.subviews.lastObject;
    if ([refreshView.refrshLabel.text isEqualToString:@"下拉更新..."]) {
    }else{
        [refreshView.refrshBtn setImage:[UIImage imageNamed:@"refresh-2"] forState:UIControlStateNormal];
        refreshView.refrshLabel.text = @"下拉更新...";
    }
}
*/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.refreshC.refreshing == 1) {
        XYHRefresh *refreshView =  self.refreshC.subviews.lastObject;
        refreshView.refrshBtn.frame = CGRectMake(139, 21, 22, 19);
        [refreshView.refrshBtn setImage:[UIImage imageNamed:@"refresh-1"] forState:UIControlStateNormal];
        refreshView.refrshLabel.text = @"更新中...";
        //http://localhost:3000/photolist?limit=20&offset=0
        //真机测试 IP为192.168.10.4
        [XYHHttpTool XYH_GET:@"http://192.168.10.4:3000/photolist?limit=20&offset=0" parameters:nil success:^(id  _Nonnull responseObject) {
                NSArray *newArray = [photolistModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"photolist"]];
                NSRange range = NSMakeRange(0, newArray.count);
                NSIndexSet *index = [NSIndexSet indexSetWithIndexesInRange:range];
                [self.photolistArray insertObjects:newArray atIndexes:index];
                [self.refreshC endRefreshing];
                [self.tableview reloadData];
            } failure:^(NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
                [self.refreshC endRefreshing];
                XYHRefresh *refreshView =  self.refreshC.subviews.lastObject;
                [refreshView.refrshBtn setImage:[UIImage imageNamed:@"refresh-2"] forState:UIControlStateNormal];
                refreshView.refrshLabel.text = @"下拉更新...";
            }];
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self.refreshC endRefreshing];
            XYHRefresh *refreshView =  self.refreshC.subviews.lastObject;
            [refreshView.refrshBtn setImage:[UIImage imageNamed:@"refresh-2"] forState:UIControlStateNormal];
            refreshView.refrshLabel.text = @"下拉更新...";
        });
         */
    }
}



-(void)refreshandel:(UIRefreshControl *)refresh{
        XYHRefresh *refreshView =  refresh.subviews.lastObject;
        [refreshView.refrshBtn setImage:[UIImage imageNamed:@"refresh-3"] forState:UIControlStateNormal];
        refreshView.refrshLabel.text = @"松开更新...";
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor redColor];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(-6, 8, 21, 24)];
    imageview.image = [UIImage imageNamed:@"icon-1"];
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"热门";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentLeft;
    [lable sizeToFit];
    lable.frame = CGRectMake(20, 1, 60, 40);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [view addSubview:imageview];
    [view addSubview:lable];
    self.navigationItem.titleView = view;
    
}


-(void)loadPhotolist{
    [XYHHttpTool XYH_GET:@"http://192.168.10.4:3000/photolist?limit=20&offset=0" parameters:nil success:^(id  _Nonnull responseObject) {
        self.photolistArray = [photolistModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"photolist"]];
        [self.tableview reloadData];
        [XYHFMDBTool saveWithPhotoList:self.photolistArray];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photolistArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SquareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SquareCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.photolistModel = self.photolistArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRGBHex:0xe7e7e7];
    
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
        detailvc.isUserDetailPhoto = NO;
        detailvc.detailModel = cell.photolistModel;
    });
    
}







@end
