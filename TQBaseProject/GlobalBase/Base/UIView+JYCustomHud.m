//
//  UIView+JYCustomHud.m
//  JYWave
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIView+JYCustomHud.h"
#import "JYCustomHudView.h"
#import <MBProgressHUD/MBProgressHUD.h>


@implementation UIView (JYCustomHud)
- (MBProgressHUD *)showCustomActivityHUDWithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeCustomView;
    JYCustomHudView  *view = [[JYCustomHudView alloc] initWithText:text stlye:JYCustomHudViewIndicator];
    hud.customView = view;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

- (MBProgressHUD *)showCustomHUDWithText:(NSString *)text{
//    if (text == nil || text.length <1) {
//        return;
//    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    JYCustomHudView  *view = [[JYCustomHudView alloc] initWithText:text stlye:JYCustomHudViewAlert];
    hud.customView = view;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.5];
    return hud;
}

- (void)hideCustomHUD{
    [MBProgressHUD hideHUDForView:self animated:YES];
    [MBProgressHUD hideHUDForView:self animated:YES];
}


- (void)showLoading {
    [self showLoadingWithText:@"正在加载..."];
}
- (void)showSending {
    [self showLoadingWithText:@"正在发送..."];
}

- (void)showLoadingWithText:(NSString *)text {
//    if ([text isKindOfClass:[NSString class]]) {
//
//    }
    [self showCustomActivityHUDWithText:text];
    
}

- (void)showAlertWithText:(NSString *)text {
    if ([text isKindOfClass:[NSString class]]) {
        [self showCustomHUDWithText:text];
    }
}

- (void)hideLoading {
    [self hideCustomHUD];
}

- (void)tuYashowLoading{
    MBProgressHUD *hud =  [self showCustomActivityHUDWithText:@""];
    hud.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = NO;
    });
    
}



@end
