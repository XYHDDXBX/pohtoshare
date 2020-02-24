//
//  XYHRefresh.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/22.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHRefresh : UIView
@property (weak, nonatomic) IBOutlet UIButton *refrshBtn;
@property (weak, nonatomic) IBOutlet UILabel *refrshLabel;

+(instancetype)refresh;

@end

NS_ASSUME_NONNULL_END
