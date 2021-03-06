//
//  XYHPhotoDeatilVC.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "photolistModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYHPhotoDeatilVC : UIViewController

@property (strong, nonatomic) photolistModel  *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *deleatBtn;
@property (weak, nonatomic) IBOutlet UILabel *deleatLabel;
@property(nonatomic,assign)BOOL isUserDetailPhoto;

@end

NS_ASSUME_NONNULL_END
