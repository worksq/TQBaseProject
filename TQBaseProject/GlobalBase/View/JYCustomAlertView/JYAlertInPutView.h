//
//  JYAlertInPutView.h
//  JYWave
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

typedef NSString *(^CheakContent)(NSString *text);
typedef void(^TapCancel)(void);
typedef void(^TapDetermine)(NSString *text);


@interface JYAlertInPutView : MMPopupView
@property (nonatomic, assign) NSUInteger maxInputLength;
@property (nonatomic, assign) BOOL inputNumber;

+ (JYAlertInPutView *)showJYInPutViewWithInputTitle:(NSString *)title
                               detail:(NSString *)detail
                          UITextField:(void(^)(UITextField *))textFieldblock
                          placeholder:(NSString *)inputPlaceholder
                         cheakContent:(CheakContent)cheakContent
                            tapCancel:(TapCancel)tapCancel
                         tapDetermine:(TapDetermine)determine;

@end
