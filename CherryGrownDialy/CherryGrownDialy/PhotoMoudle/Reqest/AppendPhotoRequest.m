//
//  AppendPhotoRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/22.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendPhotoRequest.h"

@implementation AppendPhotoRequest

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postUploadData:@"uploadPhoto"];
    return postUrl;
}
@end
