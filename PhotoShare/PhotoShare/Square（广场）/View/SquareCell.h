//
//  SquareCell.h
//  tableview测试
//
//  Created by yuhangxi on 2020/2/18.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "photolistModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SquareCell : UITableViewCell

@property (strong, nonatomic) photolistModel  *photolistModel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
