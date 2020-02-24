//
//  potolistModel.h
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface photolistModel : NSObject

@property (nonatomic, copy) NSString *photoNo;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *posterName;
@property (nonatomic, copy) NSString *province;
@property(nonatomic,assign) int favorite;
@property (nonatomic, copy) NSString *reason;

@end

NS_ASSUME_NONNULL_END
