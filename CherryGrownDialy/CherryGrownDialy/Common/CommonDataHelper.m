//
//  CommonDataHelper.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CommonDataHelper.h"


static NSString* const kLoginUserKey = @"LoginUserKey";


static CommonDataHelper* defaultCommonDataManager = nil;

@interface CommonDataHelper()

@property (nonatomic, strong) NetworkStatusUtil* networkUtil;

@end


@implementation CommonDataHelper

+ (CommonDataHelper*) defaultManager
{
    if (!defaultCommonDataManager) {
        defaultCommonDataManager = [[CommonDataHelper alloc] init];
    }
    return defaultCommonDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self makeTestTagModels];
    }
    return self;
}

- (void) makeTestTagModels{
    NSArray* tagNames = @[@"和爸爸一起", @"和妈妈一起", @"乖乖地吃饭", @"大哭大闹", @"调皮捣蛋", @"认真学习", @"愉快的玩耍", @"和小伙伴分享"];
    NSMutableArray* tagModels = [NSMutableArray array];
    [tagNames enumerateObjectsUsingBlock:^(NSString* name, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel* model = [[TagModel alloc] init];
        [model setName:name];
        [model setId:idx + 1];
        [tagModels addObject:model];
    }];
    
    [self setTagsList:tagModels];
    
}

#pragma mark settingAndGetting
- (NetworkStatusUtil*) networkUtil
{
    if (!_networkUtil) {
        _networkUtil = [[NetworkStatusUtil alloc] init];
    }
    return _networkUtil;
}


#pragma mark - 网络状态

- (void) checkNetowrkStatus:(NetworkStatusChanged) block
{
    [self.networkUtil setNetworkStatusChangeBlock:block];
}


- (AFNetworkReachabilityStatus) networkStatus
{
    return self.networkUtil.networkStatus;
}

- (NSString*) loginedUserId{
    NSDictionary* loginedUserDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:kLoginUserKey];
    if (!loginedUserDictionary || ![loginedUserDictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UserAccountModel* accountModel = [UserAccountModel mj_objectWithKeyValues:loginedUserDictionary];
    return accountModel.userId;
}

- (void) setLoginUserModel:(UserAccountModel*) accountModel{
    if(!accountModel || ![accountModel isKindOfClass:[UserAccountModel class]]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginUserKey];
        return;
    }
    
    NSDictionary* accountDictionary = [accountModel mj_keyValues];
    [[NSUserDefaults standardUserDefaults] setValue:accountDictionary forKey:kLoginUserKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}
@end
