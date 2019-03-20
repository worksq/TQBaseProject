//
//  JYCustomWaringView.h
//  test
//
//  Created by WORKSQ on 2018/10/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMPopupView/MMPopupView.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYCustomWaringView : MMPopupView

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler;

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler;

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler;

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext imageName:(NSString *)imageName cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler;

@end

NS_ASSUME_NONNULL_END
