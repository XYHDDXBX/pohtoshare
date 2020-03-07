//
//  XYHQuitPopVC.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/3/5.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, Type) {
    TypeQuit = 0,
    TypeClean
};

typedef void (^cleanBlock)(BOOL text);
NS_ASSUME_NONNULL_BEGIN

@interface XYHQuitPopVC : UIViewController

@property(nonatomic,assign)Type type;

@property (nonatomic, copy) cleanBlock block;

@end

NS_ASSUME_NONNULL_END
