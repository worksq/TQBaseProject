//
//  UITextField+Shake.h
//  Shake
//
//  Created by lanouhn on 16/3/1.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Shake)
/**
 *  抖动动画
 */
- (void)shake;
/**
 *  添加TextFiled的左边视图(图片)
 */
- (void)hd_addLeftViewWithImage:(NSString *)image;

/**
 *  获取选中光标位置
 *
 *  @return 返回NSRange
 */
- (NSRange)hd_selectedRange;

/**
 *  设置光标位置
 */
- (void)hd_setSelectedRange:(NSRange)range;
@end
