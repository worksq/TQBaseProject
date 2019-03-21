//
//  UIView+JYCustomHud.h
//  JYWave
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIView (JYCustomHud)
- (MBProgressHUD *)showCustomActivityHUDWithText:(NSString *)text;
- (MBProgressHUD *)showCustomHUDWithText:(NSString *)text;
- (void)hideCustomHUD;



- (void)showLoading;
- (void)showSending;
- (void)showLoadingWithText:(NSString *)text;

- (void)tuYashowLoading;

- (void)showAlertWithText:(NSString *)text;
- (void)hideLoading ;
@end
