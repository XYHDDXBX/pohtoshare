//
//  XYHPhotoDeatilVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHPhotoDeatilVC.h"
#import "XYHBarButtonItem.h"
#import "XYHpopMenumVC.h"
@interface XYHPhotoDeatilVC ()
@property (weak, nonatomic) IBOutlet UILabel *postNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;

@end

@implementation XYHPhotoDeatilVC


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"详情";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
    lable.frame = CGRectMake(0, 1, 60, 40);
    self.navigationItem.leftBarButtonItem = [XYHBarButtonItem itemWithImage:@"back-1" seletedImage:@"back-pre-1" target:self action:@selector(back)];
    [self setDetailMsg];
    
}

-(void)setDetailMsg{
    self.postNameLabel.text = self.detailModel.posterName;
    self.locationLabel.text = [self.detailModel.province stringByAppendingString:[NSString stringWithFormat:@"  %@",self.detailModel.location]];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.detailModel.reason];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    paragraphStyle.firstLineHeadIndent=25;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.detailModel.reason.length)];
    self.reasonLabel.attributedText = attributedString;
    
    NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailModel.imageUrl]];
    if (imagedata) {
        self.detailImage.image = [UIImage imageWithData:imagedata];
    }else{
        self.detailImage.image = [UIImage imageNamed:@"pho-3"];
    }
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)share:(id)sender {
    XYHpopMenumVC *popVC = [[XYHpopMenumVC alloc] init];
    
    popVC.providesPresentationContextTransitionStyle = YES;
    popVC.definesPresentationContext = YES;
    popVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
   [self presentViewController:popVC animated:NO completion:nil];
    
}

@end
