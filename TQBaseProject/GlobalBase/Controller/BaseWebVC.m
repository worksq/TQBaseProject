//
//  BaseNavigationController.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseWebVC.h"
#import "TQBaseProject.h"
#import <MJRefresh/MJRefresh.h>
#import <QMUIKit/QMUIKit.h>

typedef void (^runCaseBlock)(id);

@interface BaseWebVC ()<WKScriptMessageHandler>

@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *reloadItem;

@property (nonatomic, strong) WKWebViewConfiguration* webViewConfig;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic,strong) NSMutableDictionary *runBlockDict;


@end

@implementation BaseWebVC

+ (instancetype)loadWithURLString:(NSString *)urlString {
    return [self loadWithURLString:urlString params:nil cookieParams:nil];
}

+ (instancetype)loadWithURLString:(NSString *)urlString params:(NSDictionary *)params cookieParams:(NSDictionary *)cookieParams {
    BaseWebVC *vc = [[self alloc] init];
    vc.urlString = urlString;
    vc.params = params;
    vc.cookieParams = cookieParams;
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest];
    [self configNavItem];
    self.navigationItem.rightBarButtonItem = self.reloadItem;
    self.canPullRefresh = YES;
    self.haveTopProgress = YES;
}

- (void)dealloc {
    [self destroyWebView];
}

- (void)destroyWebView {
    [self removeScriptMessageHandlerWithName:_runBlockDict.allKeys];
    [_runBlockDict removeAllObjects];
    _runBlockDict = nil;
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.webView stopLoading];
    [self.webView.configuration.userContentController removeAllUserScripts];
    
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    self.webView = nil;
}

- (void)headerRefreshing {
    [self.webView reload];
//    [self loadRequest];
    [self.webView.scrollView.mj_header endRefreshing];
}

#pragma mark 加载请求
- (void)loadRequest {
    if (self.urlString.length == 0) {
        return;
    }
    [self configParams];
    self.url = [NSURL URLWithString:self.urlString];
    self.request = [NSMutableURLRequest requestWithURL:self.url];
    [self configAjaxCookieParams];
    [self configCookieParams];
    
    [self createWebView];
    [self.webView loadRequest:self.request];
}

- (void)createWebView {
    [self.webView removeFromSuperview];
    [self destroyWebView];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webViewConfig];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //添加此属性可触发侧滑返回上一网页与下一网页操作
    self.webView.allowsBackForwardNavigationGestures = YES;
    //进度监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    self.progressView.tintColor = [UIColor greenColor];
    self.progressView.trackTintColor = [UIColor clearColor];
    [self.webView addSubview:self.progressView];
    
//    [self addScriptMessageHandlerWithName:self.runBlockDict.allKeys];
    
}

- (void)callJS:(NSString *)jsMethod {
    [self callJS:jsMethod handler:nil];
}

- (void)callJS:(NSString *)jsMethod handler:(void (^)(id response, NSError *error))handler {
    NSLog(@"call js:%@",jsMethod);
    [self evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        handler ? handler(response,error) : NULL;
    }];
}

/** 调用JS */
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
{
    NSString *promptCode =javaScriptString;
    [_webView evaluateJavaScript:promptCode completionHandler:completionHandler];
}

/**
 *  注入 meaasgeHandler
 *  @param nameArr 脚本
 */
- (void)addScriptMessageHandlerWithName:(NSArray<NSString *> *)nameArr 
{
    /* removeScriptMessageHandlerForName 同时使用，否则内存泄漏 */
    for (NSString * objStr in nameArr) {
        @try{
            [self.webViewConfig.userContentController addScriptMessageHandler:self name:objStr];
        }@catch (NSException *e){
            NSLog(@"异常信息：%@",e);
        }@finally{
            
        }
    }
}

//移除脚本
- (void)removeScriptMessageHandlerWithName:(NSArray<NSString *> *)nameArr{
    for (NSString * objStr in nameArr) {
        @try{
            [self.webViewConfig.userContentController removeScriptMessageHandlerForName:objStr];
        }@catch (NSException *e){
            NSLog(@"异常信息：%@",e);
        }@finally{
            
        }
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@" message.body =   %@ ",message.body);
    NSLog(@" message.name =   %@ ",message.name);
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
   ((runCaseBlock)self.runBlockDict[message.name])(message.body);
}

- (void)addScriptMessageWithName:(NSString *)name complete:(void(^)(id obj))complete{
    if (name == nil) {
        return;
    }
    if (complete == nil) {
        complete = ^(id obj){
        };
    }
    [self addScriptMessageHandlerWithName:@[name]];
    NSDictionary *dict = @{name:complete};
    [self.runBlockDict addEntriesFromDictionary:dict];
}

// 配置 url 后面的参数
- (void)configParams {
    
    if (self.params) {
        NSMutableArray *paramStringArr = [NSMutableArray array];
        [self.params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *paramStr = [NSString stringWithFormat:@"%@=%@", key, obj];
            [paramStringArr addObject:paramStr];
        }];
        NSString *paramString = [paramStringArr componentsJoinedByString:@"&"];
        if ([self.urlString containsString:@"?"]) {
            self.urlString = [NSString stringWithFormat:@"%@&%@", self.urlString, paramString];
        }else{
            self.urlString = [NSString stringWithFormat:@"%@?%@", self.urlString, paramString];
        }
    }
}

// 配置 
- (void)configCookieParams {
    if (self.cookieParams) {
        NSMutableString *cookieString = [NSMutableString string];
        [self.cookieParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            NSString *paramStr = [NSString stringWithFormat:@"%@=%@;", key, obj];
            [cookieString appendString:paramStr];
        }];
        
        [self.request addValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
}

// 配置 Cookie
- (void)configAjaxCookieParams {
    NSMutableString *ajaxCookieParamString = [NSMutableString string];
    if (self.cookieParams) {
        NSArray *keyArr = [self.cookieParams allKeys];
        for (NSInteger i = 0; i < keyArr.count; i++) {
            NSString *ajaxCookieParamStr = nil;
            ajaxCookieParamStr = [NSString stringWithFormat:@"document.cookie = '%@=%@';", keyArr[i], [self.cookieParams valueForKey:keyArr[i]]];
            [ajaxCookieParamString appendString:ajaxCookieParamStr];
        }
    }
    
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource: ajaxCookieParamString
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.webViewConfig.userContentController addUserScript:cookieScript];
}

#pragma mark 计算webView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (self.haveTopProgress) {
            if (newprogress == 1) {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            }
            else {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        }
    }
    else if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        NSString *navTitle = [change objectForKey:NSKeyValueChangeNewKey];
        self.title = navTitle;
    }
    else if (object == self.webView && [keyPath isEqualToString:@"canGoBack"]) {
        [self configNavItem];
    }
}

#pragma mark 导航栏的按钮
- (void)configNavItem {
    if (self.webView.canGoBack) {
        if (self.navigationController.viewControllers.count > 1) {
            self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
        } else {
            self.navigationItem.leftBarButtonItems = @[self.backItem];
        }
    } else {
        if (self.navigationController.viewControllers.count > 1) {
            self.navigationItem.leftBarButtonItems = @[self.backItem];
        } else {
            self.navigationItem.leftBarButtonItems = nil;
        }
    }
}

#pragma mark - ***** 按钮点击事件
#pragma mark 返回按钮点击
- (void)backBtnAction:(UIButton *)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self destroyWebView];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 关闭按钮点击
- (void)colseBtnAction:(UIButton *)sender {
    [self destroyWebView];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 刷新按钮点击
- (void)reloadBtnAction:(UIButton *)sender{
    [self.webView reload];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"页面开始加载时调用");
    [self configAjaxCookieParams];
//    [self configCookieParams];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    NSLog(@"当内容开始返回时调用");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"在收到响应后，决定是否跳转");
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    completionHandler(@"http");
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(YES);
}

// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@",message);
    completionHandler();
}

- (WKWebViewConfiguration *)webViewConfig {
    if (!_webViewConfig) {
        _webViewConfig = [[WKWebViewConfiguration alloc] init];
        _webViewConfig.preferences = [[WKPreferences alloc] init];
        _webViewConfig.userContentController = [[WKUserContentController alloc] init];
    }
    return _webViewConfig;
}

- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        UIImage *backImage = [UIImage imageNamed:@"nav_back_black"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *backBtn = [[UIButton alloc] init];
        backBtn.frame = CGRectMake(0, 0, 40, 40);
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn setImage:backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        UIImage *closeImage = [UIImage imageNamed:@"nav_close_black"];
        closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *closeBtn = [[UIButton alloc] init];
        closeBtn.frame = CGRectMake(0, 0, 40, 40);
        closeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [closeBtn setImage:closeImage forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(colseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    }
    return _closeItem;
}

- (UIBarButtonItem *)reloadItem{
    if (!_reloadItem) {
        UIImage *reloadImage = [UIImage imageNamed:@"nav_reload_back"];
        reloadImage = [reloadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *reloadBtn = [[UIButton alloc] init];
        reloadBtn.frame = CGRectMake(0, 0, 40, 40);
        reloadBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [reloadBtn setImage:reloadImage forState:UIControlStateNormal];
        [reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _reloadItem = [[UIBarButtonItem alloc] initWithCustomView:reloadBtn];
    }
    return _reloadItem;
}

// set
- (void)setCanPullRefresh:(BOOL)canPullRefresh {
    _canPullRefresh = canPullRefresh;
    if (_canPullRefresh) {
//        [self setupRefresh:self.webView.scrollView option:(NJHeaderRefresh | NJFooterDefaultHidden)];
    } else {
        self.webView.scrollView.mj_header = nil;
    }
}

- (void)setHaveTopProgress:(BOOL)haveTopProgress {
    _haveTopProgress = haveTopProgress;
    self.progressView.hidden = !_haveTopProgress;
}

- (void)setCookieParams:(NSDictionary *)cookieParams {
    _cookieParams = cookieParams;
}

/**
 保存键值对
 CookieSaveValue(final String value, final String key)
 获取键值对
 CookieGetValue(final String key)
 回调键值对的值（CookieGetValue方法的回调）
 QXCookieGetValue(key, value);
 移除键值对
 CookieRemoveValue(final String key)
 清空键值对
 CookieRemoveAllValue()
 */
- (NSMutableDictionary *)runBlockDict
{
    if (_runBlockDict == nil) {
        WeakSelf(self);
        NSDictionary *dict =
        @{
          @"CookieSaveValue":
              ^(id body) {
                  if ([body isKindOfClass:[NSDictionary class]]) {
                      NSString *key = [body objectForKey:@"key"];
                      NSString *value = [body objectForKey:@"value"];
                      if (key && value) {
                          [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
                      }
                  }
              },
          @"CookieGetValue":
              ^(id body) {
                  if ([body isKindOfClass:[NSString class]]) {
                      NSString *key = body;
                      id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
                      [weakself callJS:[NSString stringWithFormat:@"QXCookieGetValue(%@,%@)",key,obj]];
                  }
              },
          @"CookieRemoveValue":
              ^(id body) {
                  if ([body isKindOfClass:[NSString class]]) {
                      NSString *key = body;
                      [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
                  }
              },
          @"CookieRemoveAllValue":
              ^(id body) {
                  NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
                  NSDictionary *dictionary = [defatluts dictionaryRepresentation];
                  for(NSString *key in [dictionary allKeys]){
                      [defatluts removeObjectForKey:key];
                  }
                  [defatluts synchronize];
              },
          };
        _runBlockDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return _runBlockDict;
}

@end
