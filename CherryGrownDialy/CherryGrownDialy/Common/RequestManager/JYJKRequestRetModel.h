//
//  JYJKRequestRetModel.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestErrorCode) {
    Error_None = 0,
    Error_NetworkInvalid = -1,  //无网络连接
    Error_InvalidParam = -2,    //参数错误
    Error_NetworkError = -3,    //网络错误
};

@interface JYJKRequestRetModel : NSObject

@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, retain) NSString* errorMessage;
@property (nonatomic, retain) id result;

@end
