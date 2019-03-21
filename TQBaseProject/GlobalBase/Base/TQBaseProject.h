//
//  TQBaseProject.h
//  TQBaseProject
//
//  Created by WORKSQ on 2019/3/20.
//  Copyright © 2019 WORKSQ. All rights reserved.
//

#ifndef TQBaseProject_h
#define TQBaseProject_h


#ifdef __OBJC__
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import <YYCategories/YYCategories.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "JYLogManager.h"
#import "UIView+Extension.h"
#import "UIView+JYCustomHud.h"
#import "UIViewController+CustomHud.h"
#import "NSString+Extension.h"
#endif


#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RScreenWidth MIN(ScreenWidth, ScreenHeight)
#define RScreenHeight MAX(ScreenWidth, ScreenHeight)

#define W6(X) ((RScreenWidth > 414 ? 414 * 1.3 : RScreenWidth) * ((X) / 375.f))
#define H6(X) ((RScreenHeight) * ((X) / 667.f))
#define ISIPHONE5 [UIScreen mainScreen].bounds.size.width <= 320
#define ISIPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISIPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define WeakSelf(type) __weak typeof(type) weak##type = type;

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//字体
#define UIFontMakebold(size) [UIFont boldSystemFontOfSize:size]
#define UIFontMake(size) [UIFont systemFontOfSize:size]
//#define UIFontMediumMake(sizefont) [UIFont fontWithName:@"HelveticaNeue" size:sizefont]
#define UIFontMediumMake(sizefont) [UIFont fontWithName:@"HelveticaNeue-Medium" size:sizefont]

//颜色
#define RGB(R, G, B)            RGBA(R, G, B, 1.0)
#define RGBA(R, G, B, A)        [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:A]
#define UIColorFromHex(s)       [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0  blue:((s & 0xFF))/255.0  alpha:1.0]
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//主题色

#define TINECOLORA(a) RGBA(86, 105, 255, a)
//#define TINECOLORA(a) RGBA(79, 149, 243, a)
#define TINECOLOR TINECOLORA(1)

//沙盒路径
#define JYDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//app版本
#define JYAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define JYSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define JYCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define JYLS(localized) NSLocalizedString(localized, nil)

#define SafeDicObj(obj) ((obj) ? (obj) : @"")

#endif /* TQBaseProject_h */
