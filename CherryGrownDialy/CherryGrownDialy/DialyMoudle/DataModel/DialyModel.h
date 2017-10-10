//
//  DialyModel.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/10.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DialyModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, retain) NSString* createTime;
@property (nonatomic, retain) NSString* createUserId;
@property (nonatomic, retain) NSString* createUserName;
@property (nonatomic, assign) NSInteger cateId;
@property (nonatomic, retain) NSString* cateName;
@property (nonatomic, retain) NSString* tags;
@property (nonatomic, retain) NSString* content;

@end
