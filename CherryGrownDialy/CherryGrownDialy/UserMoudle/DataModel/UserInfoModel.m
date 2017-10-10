//
//  UserInfoModel.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (NSString*) genderString
{
    NSString* genderString = @"未知";
    switch (self.gender) {
        case 1:
        {
            genderString = @"男";
            break;
        }
        case 2:
        {
            genderString = @"女";
            break;
        }
        default:
            break;
    }
    
    return genderString;
}
@end
