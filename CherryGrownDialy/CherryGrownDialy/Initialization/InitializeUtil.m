//
//  InitializeUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "InitializeUtil.h"
#import "CommonDataHelper.h"
#import "UserLoginViewController.h"

@implementation InitializeUtil

- (void) startInitialize
{
    AFNetworkReachabilityStatus networkStatus = [CommonDataHelper defaultManager].networkStatus;
    switch (networkStatus)
    {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            //网络连接可用,继续判断用户是否已登录
            [self checkUserHasBeenLogined];
            return;
        }
            break;
            
        default:
            break;
    }
    //检查网络连接
    __weak typeof(self) weakSelf = self;
    [[CommonDataHelper defaultManager] checkNetowrkStatus:^(AFNetworkReachabilityStatus state) {
        if (!weakSelf) {
            return ;
        }
        [weakSelf networkStatusChange:state];
    }];
}

- (void) networkStatusChange:(AFNetworkReachabilityStatus) networkStatus
{
    switch (networkStatus)
    {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            //网络连接可用,继续判断用户是否已登录
            [self checkUserHasBeenLogined];
            return;
        }
            break;
            
        default:
            break;
    }
    __weak typeof(self) weakSelf = self;
    [self showAlertMessage:@"网络连接不可用，请检查手机网络连接。" handler:^(UIAlertAction * _Nullable action) {
        [weakSelf performSelector:@selector(startInitialize) withObject:nil afterDelay:0.1];
    }];
}

#pragma mark - user login

- (void) checkUserHasBeenLogined
{
    NSString* loginedUserId = [CommonDataHelper defaultManager].loginedUserId;
    if (loginedUserId && loginedUserId.length > 0) {
        //用户已经登录
        [self userHasBeenLogined];
    }
    else
    {
        
        //用户还没有登录，进入登录界面
        __weak typeof(self) weakSelf = self;
        [UserLoginViewController showWithBlock:^{
            //登录成功
            if(!weakSelf)
            {
                return ;
            }
            [weakSelf userHasBeenLogined];
        }];
            
       
    }
}

- (void) userHasBeenLogined{
    //获取分类列表
    [self performSelector:@selector(loadCategoryList) withObject:nil afterDelay:0.5];
    //[self performSelector:@selector(entryMainPage) withObject:nil afterDelay:0.5];
    //[self loadCategoryList];
    
}

#pragma mark - get cate and tags list
- (void) loadCategoryList{
    [CategoryMoudleUtil startLoadCategoryList:self resultSelector:@selector(categoryListLoaded:) returnSelector:@selector(categoryListReturn:)];
}

- (void) categoryListLoaded:(id) result{
    if (result && [result isKindOfClass:[NSArray class]])
    {
        //保存分类列表
        NSArray* categoryList = (NSArray*) result;
        [[CommonDataHelper defaultManager] setCategoryList:categoryList];
    }
}

- (void) categoryListReturn:(JYJKRequestRetModel*) retModel{
    
    if (retModel.errorCode != Error_None) {
        //获取失败
        [self showAlertMessage:retModel.errorMessage];
        return;
    }
    
    //获取分类列表成功，获取标签
    [self loadTagList];
}


- (void) loadTagList{
    [CategoryMoudleUtil startLoadTagList:self resultSelector:@selector(tagsListLoaded:) returnSelector:@selector(tagsListReturn:)];
}

- (void) tagsListLoaded:(id) result{
    if (result && [result isKindOfClass:[NSArray class]])
    {
        //保存标签列表
        NSArray* tagList = (NSArray*) result;
        [[CommonDataHelper defaultManager] setTagsList:tagList];
    }
}

- (void) tagsListReturn:(JYJKRequestRetModel*) retModel{
    
    if (retModel.errorCode != Error_None) {
        //获取失败
        [self showAlertMessage:retModel.errorMessage];
        return;
    }
    
    //获取标签列表成功，进入首页
    [self performSelector:@selector(entryMainPage) withObject:nil afterDelay:0.5];
}

- (void) entryMainPage{
    [[ViewControllerManager defaultManager] entryHomePage];
}
@end
