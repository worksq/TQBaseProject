//
//  UITextField+Shake.m
//  Shake
//
//  Created by lanouhn on 16/3/1.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "UITextField+Shake.h"

/**
 * 为textField扩展一个左右晃动的动画
 */

@implementation UITextField (Shake)

- (void)shake {
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyFrame.duration = 0.3;
    CGFloat x = self.layer.position.x;
    keyFrame.values = @[@(x + 30), @(x - 30), @(x + 20), @(x - 20), @(x + 10), @(x - 10), @(x + 5), @(x - 5)];
    [self.layer addAnimation:keyFrame forKey:@"shake"];

}
- (NSRange)hd_selectedRange
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)hd_setSelectedRange:(NSRange)range
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

-(void)hd_addLeftViewWithImage:(NSString *)image
{
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.bounds;
    
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end
