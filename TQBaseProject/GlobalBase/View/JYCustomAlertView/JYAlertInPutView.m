//
//  JYAlertInPutView.m
//  JYWave
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JYAlertInPutView.h"
#import <MMPopupView/MMAlertView.h>
#import <Masonry/Masonry.h>
#import "TQBaseProject.h"


//FOUNDATION_EXPORT static NSString const *JYAlertInPutViewKey;



@interface JYAlertInPutView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIView      *buttonView;

@property (nonatomic, strong) NSArray     *actionItems;

@property (nonatomic,assign) BOOL isHaveDian;

@property (nonatomic,copy) CheakContent cheakContent;
@property (nonatomic,copy) TapCancel tapCancel;
@property (nonatomic,copy) TapDetermine tapDetermine;

@end

@implementation JYAlertInPutView

+ (JYAlertInPutView *)showJYInPutViewWithInputTitle:(NSString *)title
                               detail:(NSString *)detail
                          UITextField:(void(^)(UITextField *))textFieldblock
                          placeholder:(NSString *)inputPlaceholder
                         cheakContent:(CheakContent)cheakContent
                            tapCancel:(TapCancel)tapCancel
                         tapDetermine:(TapDetermine)determine{
    JYAlertInPutView *view = [[JYAlertInPutView alloc] initWithInputTitle:title detail:detail UITextField:textFieldblock placeholder:inputPlaceholder cheakContent:cheakContent tapCancel:tapCancel tapDetermine:determine];
    [view show];
    return view;
}

- (instancetype)initWithInputTitle:(NSString *)title
                            detail:(NSString *)detail
                       UITextField:(void(^)(UITextField *))textFieldblock
                       placeholder:(NSString *)inputPlaceholder
                      cheakContent:(CheakContent)cheakContent
                         tapCancel:(TapCancel)tapCancel
                      tapDetermine:(TapDetermine)determine{
    
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    NSArray *items =@[
                      MMItemMake(config.defaultTextCancel, MMItemTypeNormal, nil),
                      MMItemMake(config.defaultTextConfirm, MMItemTypeHighlight, nil)
                      ];
    JYAlertInPutView *view = [[JYAlertInPutView alloc] init];
    [view WithTitle:title detail:detail items:items inputPlaceholder:inputPlaceholder tapDetermine:determine];
    view.cheakContent = cheakContent;
    view.tapCancel = tapCancel;
    if (textFieldblock) {
        textFieldblock(view.inputView);
    }

    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)WithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 tapDetermine:(TapDetermine)determine
{
    
        NSAssert(items.count>0, @"Could not find any items.");

    
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        
        self.type = MMPopupTypeAlert;
        self.withKeyboard = (determine!=nil);
        
        self.tapDetermine = determine;
        self.actionItems = items;
        
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        self.layer.borderColor = config.splitColor.CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(290);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
    
    
    
        if ( title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(20);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
            }];
            self.titleLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if (detail) {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(15);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.backgroundColor;
            self.detailLabel.text = detail;
            lastAttribute = self.detailLabel.mas_bottom;
        }
        self.inputView = [self getTextField];
        self.inputView.placeholder = inputPlaceholder;
        [self addSubview:self.inputView];
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (detail) {
                make.top.equalTo(lastAttribute).offset(35);
            }else{
                make.top.equalTo(lastAttribute).offset(20);
            }
            
            make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
            make.height.mas_equalTo(44);
        }];
        lastAttribute = self.inputView.mas_bottom;
           
       
        
    
        
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            MMPopupItem *item = items[i];
            UIButton *btn = [self customButton];
            [btn setTitle:item.title forState:UIControlStateNormal];
            btn.tag = i;
            if (item.highlight) {
                btn.backgroundColor = TINECOLOR;
            }else{
                btn.backgroundColor = RGBA(153, 153, 153, 1);
            }
            [self addSubview:btn];
            if (i == 0) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(120, 44));
                    make.left.equalTo(self.inputView);
                    make.top.equalTo(lastAttribute).offset(19);
                }];
            }else{
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(120, 44));
                    make.right.equalTo(self.inputView);
                    make.top.equalTo(lastAttribute).offset(19);
                }];
                lastAttribute = btn.mas_bottom;
            }
            
            
            
            
        }
    
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"JYCustomAlertView_1"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.right.equalTo(self);
    }];
    
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(lastAttribute).offset(21);
            
        }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    

}

- (UIButton *)customButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn setExclusiveTouch:YES];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5.f;
    return btn;
}


- (void)actionButton:(UIButton*)btn
{
    
    
    if (btn.tag == 0) {
         [self hide];
        if (self.tapCancel) {
            self.tapCancel();
        }
        return;
    }
    if (self.inputView.text.length < 1) {
        
        return;
    }
    
    self.detailLabel.text = nil;
    if (self.cheakContent) {
         NSString *text = self.cheakContent(self.inputView.text);
        if (text) {
            self.detailLabel.text = text;
            self.detailLabel.textColor = [UIColor redColor];
        }else{
            [self hide];
            if (self.tapDetermine) {
                self.tapDetermine(self.inputView.text);
            }
            
        }
    }else{
        [self hide];
        if (self.tapDetermine) {
            self.tapDetermine(self.inputView.text);
        }
    }
    
   
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
    
}

- (void)hideKeyboard
{
    [self endEditing:YES];
}

- (UILabel *)getPlaceholderLabelWithtext:(NSString *)text{
    if (text.length < 1) return nil;
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"  %@  ",text];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}

- (UITextField *)getTextField{

    UITextField *inputView = [UITextField new];
    inputView.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1];
    inputView.font = [UIFont systemFontOfSize:14];
    inputView.delegate = self;
//    inputView.textAlignment = NSTextAlignmentCenter;
    inputView.layer.cornerRadius = 5.f;
    inputView.layer.masksToBounds = YES;
    inputView.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1];
    inputView.layer.borderWidth = 1;
    inputView.layer.borderColor = [UIColor colorWithRed:191/255.f green:191/255.f blue:191/255.f alpha:1].CGColor;
    inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    inputView.leftViewMode = UITextFieldViewModeAlways;
    inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
    return inputView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!_inputNumber) {
        return YES;
    }
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian = NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    return NO;
                    
                }
                //                if (single == '0') {
                //                    return YES;
                //
                //                }
            }
            if (single=='.'){
                if(!_isHaveDian){
                    //text中还没有小数点
                    _isHaveDian=YES;
                    return YES;
                    
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (_isHaveDian){
                    //存在小数点
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=(int)(range.location-ran.location);
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }else {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
        
    }else{
        return YES;
    }
    
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


@end
