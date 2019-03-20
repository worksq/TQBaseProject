//
//  BaseNavigationController.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseController.h"
#import <WebKit/WebKit.h>

@interface BaseWebVC : BaseController <WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *cookieParams;

@property (nonatomic, assign) BOOL canPullRefresh;
@property (nonatomic, assign) BOOL haveTopProgress;

+ (instancetype)loadWithURLString:(NSString *)urlString;
+ (instancetype)loadWithURLString:(NSString *)urlString params:(NSDictionary *)params cookieParams:(NSDictionary *)cookieParams;

- (void)loadRequest;

//OC 调用 JS;
- (void)callJS:(NSString *)jsMethod ;
- (void)callJS:(NSString *)jsMethod handler:(void (^)(id response, NSError *error))handler;

//注册方法
- (void)addScriptMessageWithName:(NSString *)name complete:(void(^)(id obj))complete;

@end
