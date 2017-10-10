//
//  NetworkStatusUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "NetworkStatusUtil.h"

@interface NetworkStatusUtil ()

@end

@implementation NetworkStatusUtil

- (id) init
{
    self = [super init];
    if (self) {
        [self checkNetworkStatus];
    }
    return self;
}

- (instancetype)initWithChangeBlock:(NetworkStatusChanged) changeBlock
{
    self = [super init];
    if (self) {
        _networkStatusChangeBlock = changeBlock;
        [self checkNetworkStatus];
    }
    return self;
}

//监测网络状态
- (void) checkNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _networkStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
        
        if (self.networkStatusChangeBlock) {
            self.networkStatusChangeBlock(status);
            self.networkStatusChangeBlock = nil;
        }
        
    }];
    //开始监听
    [manager startMonitoring];
}

@end
