//
//  AppendDialyRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendDialyRequest.h"



@implementation AppendDialyRequest
@synthesize reqeustParam = _reqeustParam;
- (id) initWithComment:(NSString*) content
                cateId:(NSInteger) cateId
                  tags:(NSString*) tags
{
    self = [super init];
    if (self) {
        _reqeustParam = [NSMutableDictionary dictionary];
        
        
        [_reqeustParam setValue:content forKey:@"content"];
        
        if (tags && tags.length > 0) {
             [_reqeustParam setValue:tags forKey:@"tags"];
        }
        
        if (cateId > 0)
        {
            [_reqeustParam setValue:@(cateId) forKey:@"cateId"];
        }
        
        NSString* userId = [[CommonDataHelper defaultManager] loginedUserId];
        [_reqeustParam setValue:userId forKey:@"userId"];
       
    }
    return self;
}

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postDialyServiceUrl:@"appendDialy"];
    return postUrl;
}
@end
