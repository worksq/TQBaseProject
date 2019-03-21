//
//  UIView+Extension.h

//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BlackBaseViewController.h"
typedef void (^next_view_block)(NSInteger indent, UIView *subView);

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,assign,readonly)  CGFloat right;


@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic,assign,readonly)  CGFloat bottom;


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic,assign) CGRect pixelFrame;

//@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIViewController *viewController;

+ (void)logViewTreeForMainWindow: (UIView *) aView;
/*
 遍历view 下面的所有子view
 */
+ (void)dumpView:(UIView *)aView atIndent:(int)indent block:(next_view_block)nextView;
@end
