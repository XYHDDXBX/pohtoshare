//
//  XYHpopMenumVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/23.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHpopMenumVC.h"

@interface XYHpopMenumVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrain;

@end

@implementation XYHpopMenumVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.bgView.backgroundColor = [UIColor blackColor];
//    self.bgView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.45];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bottomConstrain.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)didclickWechat:(id)sender {
}

- (IBAction)didclickYichat:(id)sender {
}
- (IBAction)didclickDismis:(id)sender {
    
    self.bottomConstrain.constant = -252;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


@end
