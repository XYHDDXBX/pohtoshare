//
//  XYHEdictVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/28.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHEdictVC.h"

@interface XYHEdictVC ()
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;

@property (weak, nonatomic) IBOutlet UITextField *viewTextF;
@property (weak, nonatomic) IBOutlet UITextField *discriTetF;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation XYHEdictVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEditMsg];

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
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.cityTextF resignFirstResponder];
    [self.viewTextF resignFirstResponder];
    [self.discriTetF resignFirstResponder];
}

@end
