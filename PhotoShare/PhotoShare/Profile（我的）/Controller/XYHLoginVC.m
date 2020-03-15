//
//  XYHLoginVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/3.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHLoginVC.h"
#import "XYHFMDBTool.h"
#import "XYHUserModel.h"
#import "XYHRegistVC.h"
#import "XYHMd5Encrypt.h"
#import "MJExtension.h"
#import "SFHFKeychainUtils.h"
@interface XYHLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextF;
@property (weak, nonatomic) IBOutlet UILabel *warnningLabel;

@end

@implementation XYHLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.warnningLabel.text = nil;
}

- (IBAction)loginBtn:(UIButton *)sender {
    XYHUserModel *userM = [XYHFMDBTool userWithSQL:@"select * from t_userinfo"];
    NSDictionary *dict=userM.mj_keyValues;
    NSData *oriData=[NSKeyedArchiver  archivedDataWithRootObject:dict];
    NSString *enpsd = [XYHMd5Encrypt MD5ForUpper32Bate:self.passwordtextF.text];
   NSString *password = [SFHFKeychainUtils getPasswordForUsername:userM.email andServiceName:@"www.netease.com.PhotoShare" error:nil];
    if (userM.email) {
        if (self.emailTextF.text.length && self.passwordtextF.text.length) {
            if ([self.emailTextF.text isEqualToString:userM.email] && [enpsd isEqualToString:password]) {
                NSLog(@"登录成功");
                userM.state = YES;
                NSDictionary *dict=userM.mj_keyValues;
                NSData *data=[NSKeyedArchiver  archivedDataWithRootObject:dict];
                [XYHFMDBTool updateWithUserstate:data OriginalState:oriData];
                [self.navigationController popViewControllerAnimated:YES];

            }else{
                self.warnningLabel.text = @"邮箱或密码错误";
            }
        }else{
            self.warnningLabel.text = @"邮箱或密码不能为空";
        }
    }else{
        self.warnningLabel.text = @"请先注册账号";
    }
}

- (IBAction)registBtn:(UIButton *)sender {
    XYHRegistVC *registvc = [[XYHRegistVC alloc] init];
    [self presentViewController:registvc animated:YES completion:nil];
    
}

- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailTextF resignFirstResponder];
    [self.passwordtextF resignFirstResponder];
}

@end
