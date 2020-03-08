//
//  XYHEdictVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/28.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHEdictVC.h"
#import "UIColor+XYHColor.h"
#import "XYHFMDBTool.h"
#import "XYHUserModel.h"
#import "XYHImage.h"
#import "photolistModel.h"
#import "XYHUserModel.h"
@interface XYHEdictVC ()
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;
@property (weak, nonatomic) IBOutlet UITextField *viewTextF;
@property (weak, nonatomic) IBOutlet UITextView *discriTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray  *allArray;


@end

@implementation XYHEdictVC

- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = (NSMutableArray *)[XYHFMDBTool photoListWithSQL:@"select * from t_photolist"];
    }
    return _allArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEditMsg];
    self.discriTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.discriTextView.layer.borderWidth = 1.0;
    self.discriTextView.layer.cornerRadius = 4.0;
    self.discriTextView.text = nil;
    self.discriTextView.textColor = [UIColor colorWithRGBHex:0xacacac];
    self.discriTextView.tintColor = [UIColor colorWithRGBHex:0xacacac];

}

-(void)setEditMsg{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"编辑";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
    self.imageView.image = self.accimage;
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)publish:(UIButton *)sender {
    XYHUserModel *userM = [XYHFMDBTool userWithSQL:@"select * from t_userinfo"];
    if (userM.state) {
        [self publishUserPhotoModel:userM];
        UIAlertController *alertSues = [UIAlertController alertControllerWithTitle:@"发布成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertSues addAction:action];
        [self presentViewController:alertSues animated:YES completion:nil];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您还没有登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}

-(void)publishUserPhotoModel:(XYHUserModel *)userM{
   
    NSString *num =@"Number 4";
    NSString *imgStr = [XYHImage UIImageToBase64Str:self.accimage];
    NSString *title = self.viewTextF.text;
    NSString *province = self.cityTextF.text;
    NSString *posterName = userM.username;
    int favorite = 1;
    NSString *reason = self.discriTextView.text;
    photolistModel *userPhotoM = [photolistModel ModelWithPhotoNo:num image:imgStr title:title location:title posterName:posterName province:province favorite:favorite reason:reason];
    NSArray *newArray = [NSArray arrayWithObject:userPhotoM];
    [XYHFMDBTool saveWithPhotoList:newArray];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.cityTextF resignFirstResponder];
    [self.viewTextF resignFirstResponder];
    [self.discriTextView resignFirstResponder];
}

@end
