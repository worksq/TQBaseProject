//
//  UIView+CustomHud.h
//  Lamp
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomHud)
- (void)showLoading;
- (void)showSending;
- (void)showLoadingWithText:(NSString *)text;
- (void)tuYashowLoading;

- (void)showAlertWithText:(NSString *)text;

- (void)hideLoading ;
@end
