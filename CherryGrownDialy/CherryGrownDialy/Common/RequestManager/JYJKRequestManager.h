//
//  JYJKRequestManager.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYJKRequest.h"
#import "JYJKRequestObservice.h"

@interface JYJKRequestManager : NSObject

+ (JYJKRequestManager*) defaultManager;

- (void) createRequest:(JYJKRequest*) request observice:(JYJKRequestObservice*) observice;

- (void) postRequestResult:(id) result request:(JYJKRequest*) request;

- (void) postRequestReturn:(NSInteger) errorCode errMessage:(NSString*) errorMessage request:(JYJKRequest*) request;

- (void) postUploadProgress:(NSInteger) progress totalPorgress:(NSInteger) totalProgress request:(JYJKRequest*) request;
@end
