//
//  PhotoInfoModel.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoInfoModel : NSObject

@property (nonatomic, retain) NSString* imageUrl;       //原图URL
@property (nonatomic, retain) NSString* thumbUrl;       //缩略图URL
@property (nonatomic, assign) NSInteger id;             
@end
