//
//  PhotoModelList.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/1.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModelList : NSObject

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, retain) NSArray<PhotoInfoModel*>* list;

@end
