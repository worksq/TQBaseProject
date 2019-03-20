//
//  JYCustomAlertView.h
//  test
//
//  Created by WORKSQ on 2018/10/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMPopupView/MMPopupView.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYCustomAlertView : MMPopupView

//选择的样式
+ (void)showAlertChooseTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapButton:(MMPopupItemHandler)Handler;

//提示的样式
+ (void)showAlertNoticeTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapButton:(MMPopupItemHandler)Handler;
+ (void)showAlertNoticeTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler;

//删除的样式
+ (void)showAlertDeleteTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapDeleteButton:(MMPopupItemHandler)Handler;

+ (instancetype)showAlertViewWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler;

+ (instancetype)showAlertViewWithTitle:(NSString *)title detailText:(NSString *)detailtext cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler;

@end

NS_ASSUME_NONNULL_END
