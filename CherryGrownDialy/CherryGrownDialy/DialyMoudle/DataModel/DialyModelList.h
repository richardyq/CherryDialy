//
//  DialyModelList.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DialyModelList : NSObject

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, retain) NSArray<DialyModel*>* list;

@end
