//
//  XYHheadView.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/26.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHheadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIButton *headbtn;

+(instancetype)headView;

@end

NS_ASSUME_NONNULL_END
