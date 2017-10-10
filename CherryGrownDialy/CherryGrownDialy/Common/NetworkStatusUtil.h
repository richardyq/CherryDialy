//
//  NetworkStatusUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//



typedef void(^NetworkStatusChanged)(AFNetworkReachabilityStatus networkStatus);

#import <Foundation/Foundation.h>

@interface NetworkStatusUtil : NSObject

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;
@property (nonatomic, strong) NetworkStatusChanged networkStatusChangeBlock;

- (instancetype)initWithChangeBlock:(NetworkStatusChanged) changeBlock;

@end
