//
//  SquareCell.m
//  tableview测试
//
//  Created by yuhangxi on 2020/2/18.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "SquareCell.h"
#import "UIColor+XYHColor.h"
#import "XYHImage.h"
@interface SquareCell()


@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *photoNo;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *province;

@end

@implementation SquareCell


-(void)setPhotolistModel:(photolistModel *)photolistModel{
    _photolistModel = photolistModel;
    self.title.text = photolistModel.title;
    self.province.text = photolistModel.province;
    self.photoNo.text = photolistModel.photoNo;
    NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:photolistModel.imageUrl]];
    if (photolistModel.favorite == 1) {
        UIImage *image = [XYHImage Base64StrToUIImage:photolistModel.imageUrl];
        self.photoImageView.image = image;
    }else{
        if (imagedata) {
            self.photoImageView.image = [UIImage imageWithData:imagedata];
        }else{
            self.photoImageView.image = [UIImage imageNamed:@"pho-3"];
        }
    }
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.backgroundColor = [UIColor colorWithRGBHex:0xffffff];
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = 0.45;
    self.bgView.layer.shadowRadius = 4;
    
    CGSize radii = CGSizeMake(4, 4);
    // 随意改变4个圆角
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.photoImageView.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.masksToBounds = NO;
    self.photoImageView.layer.mask = maskLayer;
    
}



@end
