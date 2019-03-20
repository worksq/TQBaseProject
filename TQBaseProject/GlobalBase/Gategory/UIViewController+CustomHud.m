//
//  UIView+CustomHud.m
//  Lamp
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+CustomHud.h"
#import "UIView+JYCustomHud.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (CustomHud)

- (void)showLoading {
    [self.view showLoading];
}
- (void)showSending {
    [self.view showSending];
}

- (void)showLoadingWithText:(NSString *)text {
    [self.view showLoadingWithText:text];
    
}

- (void)showAlertWithText:(NSString *)text {
    [self.view showAlertWithText:text];
}

- (void)hideLoading {
    [self.view hideLoading];
}

- (void)tuYashowLoading{
    [self.view tuYashowLoading];
}

- (void)delayShow{
    
}


@end
