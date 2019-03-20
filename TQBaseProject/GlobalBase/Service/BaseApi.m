//
//  BaseApi.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseApi.h"
NSString *const NetworkRequestErrorDomain = @"com.jiyinsz.request.validation";

@implementation BaseApi{
    NSString *_token;
    
    BOOL _requestFailed;
}

@synthesize error = _error;


- (instancetype)init {
    self = [super init];
    if (self) {
        //设置可接受的数据类型
        YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
        NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
        @try {
            [agent setValue:acceptableContentTypes forKeyPath:keypath];
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
            
        }
        
//        JYUserModel *model = [AccountManager sharedManager].currentUser;
//        _token = model.token;
    }
    return self;
}

- (NSString *)baseUrl {
    return @"https://baidu.com";
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
    
}

//默认不缓存
- (NSInteger)cacheTimeInSeconds {
    return -1;
}

//超时30秒
- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

//请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//请求体
- (id)requestArgument {
    if (_token.length>0) {
        return @{
                 @"token" : _token,
                 };
    } else {
        return @{};
    }
}

- (NSInteger)code{
    NSInteger code = [[[self responseJSONObject] objectForKey:@"result"] integerValue];
    return code;
}

- (NSString *)message {
    NSString *msg = [[self responseJSONObject] objectForKey:@"msg"];
    return msg;
}

- (id)jsonData {
    return [[self responseJSONObject] objectForKey:@"data"];
}


- (id)jsonValidator {
    // 当参数不满足条件的时候调用 失败的 block
    // 详见https://github.com/yuantiku/YTKNetwork/issues/20 非常好的解决方法
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"--------------------------------------------------------------------");
    NSLog(@"URL：%@",self.currentRequest.URL.absoluteString);
    NSLog(@"参数：%@",self.requestArgument);
    NSLog(@"返回：%@",self.responseJSONObject);
    NSLog(@"--------------------------------------------------------------------");
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"\n");
    
    
    if (self.code != 1) {
        _requestFailed = YES;
        return @{ @"TheKeyYouWillNeverUse": [NSObject class] };
    }
    
    return nil;
}

- (void)setError:(NSError *)error {
    _error = error;
}

- (NSError *)error {
    if (_requestFailed && self.code != 1) {
        return [NSError errorWithDomain:YTKRequestCacheErrorDomain code:self.code userInfo:@{NSLocalizedDescriptionKey:self.message}];
    }
    return _error;
}


@end
