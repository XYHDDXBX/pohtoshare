//
//  XYHRegistVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/3.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHRegistVC.h"
#import "XYHUserModel.h"
#import "XYHMd5Encrypt.h"
#import "XYHFMDBTool.h"
#import "XYHImage.h"
@interface XYHRegistVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UILabel *warnningLabel;

@end

@implementation XYHRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.warnningLabel.text = nil;
}

- (IBAction)registBtn:(UIButton *)sender{
    if (self.emailTextF.text.length && self.passwordTextF.text.length) {
        BOOL isEmail = [self verifyEmail:self.emailTextF.text];
        if (isEmail) {
            NSString *psdStr = [XYHMd5Encrypt MD5ForUpper32Bate:self.passwordTextF.text];
            //55E83457409A84BCD3B8D2143FC488FC
            NSString *imageStr = [XYHImage UIImageToBase64Str:[UIImage imageNamed:@"title-icon"]];
            XYHUserModel *model = [XYHUserModel modelWithEmail:self.emailTextF.text password:psdStr state:NO username:@"到底奚不奚" iconImage:imageStr];
            NSLog(@"model = %@",model);
            [XYHFMDBTool saveWithUser:model];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
           self.warnningLabel.text = @"请输入合法的邮箱";
        }
    }else{
        self.warnningLabel.text = @"邮箱或密码不能为空";
    }
    
}

-(BOOL)verifyEmail:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.emailTextF resignFirstResponder];
    [self.passwordTextF resignFirstResponder];
}

@end
