//
//  XYHSearchVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHSearchVC.h"
#import "UIColor+XYHColor.h"
#import "XYHheadView.h"
#import "XYHsearchCell.h"
#import "XYHFMDBTool.h"
#import "photolistModel.h"
#import "PinYin4Objc.h"
#import "XYHPhotoDeatilVC.h"
@interface XYHSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    BOOL searchstatus;   // search/true  history/false
}


@property (strong, nonatomic) UITableView  *tableview;
@property (strong, nonatomic) UISearchBar  *searchBar;
@property (strong, nonatomic) NSMutableArray  *photoListArr;
@property (strong, nonatomic) NSMutableArray  *updateArray;
@property (strong, nonatomic) NSMutableArray  *historyArray;
@property (strong, nonatomic) HanyuPinyinOutputFormat *formatter;
@property (strong, nonatomic) UILabel *footerLabel;

@end

@implementation XYHSearchVC

static NSString *searchID = @"search";

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([XYHsearchCell class]) bundle:nil] forCellReuseIdentifier:searchID];
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.rowHeight = 44;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 310, 30)];
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"搜索城市或者景区名";
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.layer.masksToBounds = true;
        _searchBar.layer.cornerRadius = 4;
        _searchBar.tintColor = [UIColor colorWithRGBHex:0xacacac];
//        UITextField *searchTextFied = [_searchBar valueForKeyPath:@"_searchField"];
        _searchBar.searchTextField.textColor = [UIColor colorWithRGBHex:0xacacac];
        _searchBar.searchTextField.font = [UIFont systemFontOfSize:13];
        UIImage *image = [UIImage imageNamed:@"search-1"];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
        leftImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _searchBar.searchTextField.leftView = leftImageView;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(UILabel *)footerLabel{
    if (!_footerLabel) {
        _footerLabel = [UILabel new];
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.textColor = [UIColor lightGrayColor];
        _footerLabel.font = [UIFont systemFontOfSize:12];
    }
    return _footerLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoListArr = [NSMutableArray array];
    self.updateArray = [NSMutableArray array];
    self.historyArray = [NSMutableArray array];
    searchstatus = false;
    self.footerLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"进入界面");
    [self loadPhotoListData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
    if (searchstatus == false) {
        XYHheadView *view = (XYHheadView *)self.tableview.tableHeaderView;
        view.headLabel.text = @"历史记录";
        [view.headbtn setImage:[UIImage imageNamed:@"search-3"] forState:UIControlStateNormal];
    }
        self.tableview.tableFooterView.hidden = YES;
        self.tableview.tableHeaderView.hidden = NO;
}

-(void)loadPhotoListData{
    NSArray *array = [XYHFMDBTool photoListWithSQL:@"select * from t_photolist"];
    self.photoListArr = (NSMutableArray *)array;
    
}


-(void)setupUI{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 30)];
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    [self.view addSubview:self.tableview];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchstatus) {
        return self.updateArray.count;
    }else{
        return self.historyArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XYHsearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchID];
    if (!cell) {
        cell = [[XYHsearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchID];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (searchstatus) {
        cell.model = self.updateArray[indexPath.row];
    }else{
        cell.model = self.historyArray[indexPath.row];
    }
        

    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview.tableFooterView.hidden = YES;
    self.tableview.tableHeaderView.hidden = YES;
    [self.searchBar resignFirstResponder];
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYHsearchCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    XYHPhotoDeatilVC *detailVC = [[XYHPhotoDeatilVC alloc] init];
    detailVC.detailModel = cell.model;
    
    if (self.historyArray.count) {
        for (photolistModel *model in self.historyArray) {
            if ([model.title isEqualToString:cell.model.title]){
            }else {
                [self.historyArray addObject:cell.model];
            }
        }
    }else{
        [self.historyArray addObject:cell.model];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    searchstatus = true;
    self.tableview.tableHeaderView = [XYHheadView headView];
    XYHheadView *view = (XYHheadView *)self.tableview.tableHeaderView;
    view.headLabel.text = @"历史记录";
    [view.headbtn setImage:[UIImage imageNamed:@"search-3"] forState:UIControlStateNormal];
    self.tableview.tableFooterView.hidden = YES;
    self.tableview.tableHeaderView.hidden = NO;
}

//点击键盘搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchstatus = true;
    [self showResultLable];
}

//监听文字输入变化
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
    if(searchText){
        searchstatus = true;
        XYHheadView *view = (XYHheadView *)self.tableview.tableHeaderView;
        view.headLabel.text = @"猜你想搜";
        [view.headbtn setImage:[UIImage imageNamed:@"search-4"] forState:UIControlStateNormal];
        [self.updateArray removeAllObjects];
        if ([PinyinHelper isIncludeChineseInString:searchText]) {
            for (int i=0; i<self.photoListArr.count; i++) {
                photolistModel *model = self.photoListArr[i];
                NSString *searchStr = [model.title stringByAppendingString:model.province];
                if ([searchStr rangeOfString:searchText].location != NSNotFound) {
                    [self.updateArray addObject:model];
                }
            }
        }else{
            for (int i=0; i<self.photoListArr.count; i++) {
                [self HanyuPinyinOutputFormat];
                photolistModel *model = self.photoListArr[i];
                NSString *searchStr = [model.title stringByAppendingString:model.province];
                NSString *outputPinyin=[[PinyinHelper toHanyuPinyinStringWithNSString:searchStr withHanyuPinyinOutputFormat:self.formatter withNSString:@""] lowercaseString];
                if ([[outputPinyin lowercaseString]rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
                    [self.updateArray addObject:model];
                }
            }
        }
        [self.tableview reloadData];
    }
    
    if (searchBar.text.length == 0) {
        NSLog(@"点击了clear按钮");
        XYHheadView *view = (XYHheadView *)self.tableview.tableHeaderView;
        view.headLabel.text = @"历史记录";
        [view.headbtn setImage:[UIImage imageNamed:@"search-3"] forState:UIControlStateNormal];
        searchstatus = false;
        [self.tableview reloadData];
    }
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (text.length == 0) {
        return YES;
    }
    NSUInteger length = searchBar.text.length + text.length;
    return length <= 20;
}

- (void) HanyuPinyinOutputFormat{
    HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
    formatter.caseType = CaseTypeUppercase;
    formatter.vCharType = VCharTypeWithV;
    formatter.toneType = ToneTypeWithoutTone;
    self.formatter=formatter;
}

- (void)showResultLable {
    if (self.updateArray.count==0) {
        self.footerLabel.text = @"无结果";
        self.tableview.tableHeaderView.hidden = YES;
        self.tableview.tableFooterView.hidden = NO;
        self.tableview.tableFooterView = self.footerLabel;
    }else{
        self.footerLabel.text = @"";
    }
    
}

@end
