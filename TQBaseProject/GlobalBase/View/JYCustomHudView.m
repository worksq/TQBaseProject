//
//  JYCustomHudView.m
//  JYWave
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JYCustomHudView.h"
#import "TQBaseProject.h"

@interface JYCustomHudView ()
@property (nonatomic,assign) CGFloat viewW;
@property (nonatomic,assign) CGFloat viewH;
@property (nonatomic,assign) JYCustomHudViewStlye stlye;
@end

@implementation JYCustomHudView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(_viewW, _viewH);
}

- (instancetype)initWithText:(NSString *)text stlye:(JYCustomHudViewStlye)stlye{
    if (self = [super init]) {
         self.stlye = stlye;
         [self setUpUIText:text];
    }
    return self;
}

- (void)setUpUIText:(NSString *)text {
    CGFloat leftMargin = 20.f;
    CGFloat rightMargin = 30.f;
    
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];
    self.layer.cornerRadius = 5.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowRadius = 5.f;
    
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:18];
    textLabel.text = text;
    textLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:textLabel];
    
    if (self.stlye == JYCustomHudViewAlert) {
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        CGSize size = [self sizeWithText:textLabel.text font:textLabel.font maxSize:CGSizeMake(W6(280), [UIScreen mainScreen].bounds.size.height-120)];
        
        _viewH = size.height + 20;
        _viewW = size.width + leftMargin + rightMargin;
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.width.mas_equalTo(size.width+20);
            make.center.equalTo(self);
        }];
        
      
    }else{
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag = 674;
        activityIndicator.color = [UIColor whiteColor];
        [activityIndicator startAnimating];
        [activityIndicator setHidesWhenStopped:YES];
        [self addSubview:activityIndicator];
        
        if (text.length > 0) {
            [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(leftMargin);
            }];
            
            
            CGSize size = [self sizeWithText:textLabel.text font:textLabel.font maxSize:CGSizeMake(W6(280), [UIScreen mainScreen].bounds.size.height-120)];
            _viewH = size.height + 20;
            _viewW = size.width + leftMargin + 20 + 20 + rightMargin;
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(activityIndicator.mas_right).offset(20);
                make.width.mas_equalTo(size.width);
            }];
        }else{
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
            _viewH = 90;
            _viewW = 90;
        }
    }
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
