//
//  JYJKHttpUploadRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpUploadRequest.h"

@interface JYJKHttpUploadRequest ()


@property (nonatomic, strong) NSData* uploadData;
@end


@implementation JYJKHttpUploadRequest

@synthesize reqeustParam = _reqeustParam;

- (id) initWithParams:(NSDictionary*) params
           uploadData:(NSData*) uploadData
{
    self = [super init];
    if (self) {
        _uploadData = uploadData;
        _reqeustParam = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    return self;
}

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postUploadData:@""];
    return postUrl;
}


- (AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *sessionManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sessionManager) {
            // 初始化Manager
            sessionManager = [AFHTTPSessionManager manager];
            sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
            
            sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
#ifdef kSimulation_Netwrok
            //仿真环境
            NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"httpsrequest_sm" ofType:@"cer"];
#else   //正式环境
            NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"httpsrequest" ofType:@"cer"];
#endif
            
            NSData * certData =[NSData dataWithContentsOfFile:cerPath];
            NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
            
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
            // 是否允许,NO-- 不允许无效的证书
            [securityPolicy setAllowInvalidCertificates:YES];
            // 设置证书
            [securityPolicy setPinnedCertificates:certSet];
            
            [securityPolicy setValidatesDomainName:YES];
            
            sessionManager.securityPolicy = securityPolicy;
        }
        
    });
    return sessionManager;
}

- (void) startPost:(NSString*) postUrl param:(id) param
{
    NSMutableDictionary* dicParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@", postUrl];
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager POST:stringURL parameters:dicParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         // 上传文件
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str  = [formatter stringFromDate:[NSDate date]];
         NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
         [formData appendPartWithFileData:self.uploadData name:@"photos" fileName:fileName mimeType:@"image/png"];
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         NSLog(@"PostImage progress %lld %lld", uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);

     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"上传成功");
//         [self jsonPostSuccess:task Response:responseObject];
         [weakSelf postSuccess:task Response:responseObject];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"上传失败");
//         [self jsonPostFailed:task Error:error];
          [weakSelf postFailed:task Error:error];
         NSLog(@"%@", [error localizedDescription]);
     }];
}

- (void) parserResponeData:(NSData*) responseObject
{
    if (responseObject )
    {
        NSString* strResp = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        id resp = [strResp mj_JSONObject];
        errorCode = [self parseJson:resp];
    }
}

#pragma mark - HTTP 返回数据解包
- (RequestErrorCode) parseJson:(id) resp
{
    if (!resp || ![resp isKindOfClass:[NSDictionary class]])
    {
        errorMessage = [NSString stringWithFormat:@"接口调用失败。"];
        return Error_NetworkError;
    }
    
    NSDictionary* dicResp = (NSDictionary*) resp;
    NSNumber* numerrcode = [dicResp valueForKey:@"retCode"];
    NSString* strErrMsg = [dicResp valueForKey:@"retMessage"];
    
    NSInteger errcode = [numerrcode integerValue];
    errorCode = errcode;
    if (![self errorCodeIsValid:errcode])
    {
        //接口返回非正确值
        errorMessage = strErrMsg;
        return Error_NetworkError;
    }
    
    //解析 result
    id result = [dicResp valueForKey:@"result"];
    
    if (result)
    {
        errorCode = [self paraserResultJson:result];
        if (errorCode == Error_None && reqResult) {
            //回报结果
            [[JYJKRequestManager defaultManager] postRequestResult:reqResult request:self];
        }
    }
    return Error_None;
}

- (BOOL) errorCodeIsValid:(NSInteger) errCode
{
    return errCode == 0;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    reqResult = result;
    return Error_None;
}
@end
