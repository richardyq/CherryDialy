//
//  UserInfoModel.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, retain) NSString* userId;
@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* birthday;
@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, readonly) NSString* genderString;
@end
