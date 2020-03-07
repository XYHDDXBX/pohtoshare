//
//  XYHfeedBackVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHfeedBackVC.h"
#import "XYHBarButtonItem.h"
#import "UIColor+XYHColor.h"
@interface XYHfeedBackVC ()
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation XYHfeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"反馈";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.textview.layer.borderColor = [UIColor grayColor].CGColor;
    self.textview.layer.borderWidth = 1.0;
    self.textview.layer.cornerRadius = 4.0;
    self.textview.text = nil;
    self.textview.textColor = [UIColor colorWithRGBHex:0xacacac];
    self.textview.tintColor = [UIColor colorWithRGBHex:0xacacac];
    self.navigationItem.titleView = lable;
    self.navigationItem.leftBarButtonItem = [XYHBarButtonItem itemWithImage:@"back-1" seletedImage:@"back-pre-1" target:self action:@selector(back)];
}

- (IBAction)send:(UIButton *)sender {
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textview resignFirstResponder];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
