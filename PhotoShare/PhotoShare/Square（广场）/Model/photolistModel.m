//
//  potolistModel.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/2/19.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import "photolistModel.h"

@implementation photolistModel

-(instancetype)initWithPhotoNo:(NSString *)photoNo image:(NSString *)image title:(NSString *)title location:(NSString *)location posterName:(NSString *)posterName province:(NSString *)province favorite:(int)favorite reason:(NSString *)reason{
    if (self = [super init]) {
        self.photoNo = photoNo;
        self.imageUrl = image;
        self.title = title;
        self.location = location;
        self.posterName = posterName;
        self.province = province;
        self.favorite = favorite;
        self.reason = reason;
    }
    return self;
}


+(instancetype)ModelWithPhotoNo:(NSString *)photoNo image:(NSString *)image title:(NSString *)title location:(NSString *)location posterName:(NSString *)posterName province:(NSString *)province favorite:(int)favorite reason:(NSString *)reason{
    return [[self alloc] initWithPhotoNo:photoNo image:image title:title location:location posterName:posterName province:province favorite:favorite reason:reason];
}
@end
