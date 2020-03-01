//
//  XYHsearchCell.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/26.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "XYHsearchCell.h"

@interface XYHsearchCell()

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;

@end

@implementation XYHsearchCell


- (void)setModel:(photolistModel *)model{
    _model = model;
    self.titlelabel.text = model.title;
    self.provinceLabel.text = model.province;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
