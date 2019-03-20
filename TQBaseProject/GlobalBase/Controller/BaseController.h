//
//  GloballBaseController.h
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

@interface BaseController : UIViewController

- (void)setLeftBarItemWithImageName:(NSString *)name action:(SEL)sel;
- (void)setRightBarItemWithImageName:(NSString *)name action:(SEL)sel;
- (void)setLeftBarItemWithTitle:(NSString *)name action:(SEL)sel;
- (void)setRightBarItemWithTitle:(NSString *)name action:(SEL)sel;
- (void)setBackBarItemWithTitle:(NSString *)name action:(SEL)sel;
- (void)setBackBarItemWithImageName:(NSString *)name action:(SEL)sel;
- (void)addBackItemWithAction:(SEL)sel;

@end
