//
//  JYCustomAlertView.m
//  test
//
//  Created by WORKSQ on 2018/10/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "JYCustomAlertView.h"
#import <Masonry/Masonry.h>
#import "TQBaseProject.h"



//#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//
//#define W6(X) ((ScreenWidth) * ((X) / 375.f))

@interface JYCustomAlertView ()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSString *detailText;
@property (nonatomic,copy) NSArray <MMPopupItem *> *Items;
@end

@implementation JYCustomAlertView

- (instancetype)initWithTitle:(NSString *)title detailText:(NSString *)detailtext MMPopupItems:(NSArray <MMPopupItem *> *)Items{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.title = title;
        self.detailText = detailtext;
        self.Items = Items;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.type = MMPopupTypeAlert;
    CGFloat viewW = 290;
    CGFloat topMargin = self.detailText?30:45;
    CGFloat leftMargin = 16;
    
    UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.preferredMaxLayoutWidth = viewW - (leftMargin *2);
    titleLabel.numberOfLines = 0;
    titleLabel.text = self.title;
    titleLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    titleLabel.font = titleFont;
    [self addSubview:titleLabel];
    MASViewAttribute *lastAttribute = titleLabel.mas_bottom;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(topMargin);
        make.left.equalTo(self).offset(leftMargin);
        make.right.equalTo(self).offset(-leftMargin);
    }];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    closeBtn.tag = 0;
    [closeBtn addTarget:self action:@selector(actionHide) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"JYCustomAlertView_1"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(self);
        make.top.equalTo(self);
    }];
    
    UIFont *detailFont = [UIFont systemFontOfSize:16];
    if (self.detailText) {
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.numberOfLines = 0;
        if (self.title.length < 1) {
            detailLabel.textColor = RGBA(51, 51, 51, 1);
        }else{
            detailLabel.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1];
        }
        
        detailLabel.font = detailFont;
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(titleLabel);
            make.top.equalTo(titleLabel.mas_bottom).offset(32);
        }];
        if ([self.detailText isKindOfClass:[NSString class]]){
            detailLabel.text = self.detailText;
        }else if ([self.detailText isKindOfClass:[NSMutableAttributedString class]]){
            detailLabel.attributedText = ( NSMutableAttributedString *)self.detailText;
        }
        
        lastAttribute = detailLabel.mas_bottom;
    }
    
    CGFloat buttonMargin = self.detailText?33:46;
    if (self.Items.count==1) {
        MMPopupItem *item = self.Items.firstObject;
        UIButton *btn = [self getbtn:item];
        btn.tag = 0;
        btn.backgroundColor = [UIColor colorWithRed:86/255.f green:105/255.f blue:225/255.f alpha:1];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(lastAttribute).offset(buttonMargin);
            make.size.mas_equalTo(CGSizeMake(260, 44));
        }];
        lastAttribute = btn.mas_bottom;
        
    }else if (self.Items.count >=2){
        MMPopupItem *item1 = self.Items.firstObject;
        UIButton *btn1 = [self getbtn:item1];
        btn1.tag = 0;
        [self addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-7);
            make.top.equalTo(lastAttribute).offset(buttonMargin);
            make.size.mas_equalTo(CGSizeMake(120, 44));
        }];
        
        MMPopupItem *item2 = self.Items[1];
        UIButton *btn2 = [self getbtn:item2];
        btn2.tag = 1;
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(7);
            make.top.equalTo(btn1);
            make.size.mas_equalTo(CGSizeMake(120, 44));
        }];
        lastAttribute = btn1.mas_bottom;
    }
    CGFloat margin = 25;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(viewW);
        make.bottom.equalTo(lastAttribute).offset(margin);
    }];
    
}

- (UIButton *)getbtn:(MMPopupItem *)item{
    
    UIColor *color = RGBA(153, 153, 153, 1);
    if (item.highlight) {
        color = [UIColor colorWithRed:86/255.f green:105/255.f blue:225/255.f alpha:1];
    }else if (item.disabled){
        color = [UIColor lightGrayColor];
    }
    if (item.color) {
        color = item.color;
    }
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = color;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 5.f;
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickBtn:(UIButton *)sender{
    MMPopupItem *item = self.Items[sender.tag];
    if (item.handler) {
        item.handler(sender.tag);
    }
    [self actionHide];
}



- (void)actionHide
{
    [self hide];
}


- (CGSize)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

//删除的样式
+ (void)showAlertDeleteTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapDeleteButton:(MMPopupItemHandler)Handler{
    NSArray *items = @[MMItemMake(@"取消", MMItemTypeNormal, nil),
                       MMItemMake(@"删除", MMItemTypeHighlight, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
}
//提示的样式
+ (void)showAlertNoticeTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapButton:(MMPopupItemHandler)Handler{
    NSArray *items = @[MMItemMake(@"确定", MMItemTypeNormal, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
}

//提示的样式
+ (void)showAlertNoticeTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler{
    NSArray *items = @[MMItemMake(btnTitle, MMItemTypeNormal, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
}

//选择的样式
+ (void)showAlertChooseTypeWithTitle:(NSString *)title detailText:(NSString *)detailtext tapButton:(MMPopupItemHandler)Handler{
    NSArray *items = @[MMItemMake(@"取消", MMItemTypeNormal, Handler),
                       MMItemMake(@"确定", MMItemTypeHighlight, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler{
    if (btnTitle == nil) {
        btnTitle = @"确定";
    }
    NSArray *items = @[MMItemMake(btnTitle, MMItemTypeHighlight, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
    return view;
                       
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title detailText:(NSString *)detailtext cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler{
    if (btn1Title == nil) {
        btn1Title = @"取消";
    }
    if (btn2Title == nil) {
        btn2Title = @"确定";
    }
    NSArray *items = @[MMItemMake(btn1Title, MMItemTypeNormal, Handler),MMItemMake(btn2Title, MMItemTypeHighlight, Handler)];
    JYCustomAlertView *view = [[JYCustomAlertView alloc] initWithTitle:title detailText:detailtext MMPopupItems:items];
    [view show];
    return view;
    
}


//+(void)showAlertWithType:(JYAlertType)type Title:(NSString *)title detailText:(NSString *)detailtext tapButton:(MMPopupItemHandler)Handler{
//    if (type == JYAlertDeleteType) {
//        [JYCustomAlertView showAlertDeleteTypeWithTitle:title detailText:detailtext tapDeleteButton:Handler];
//    }else if (type == JYAlertNoticeType){
//        [self showAlertNoticeTypeWithTitle:title detailText:detailtext tapButton:Handler];
//    }else if (type == JYAlertChooseType){
//        [self showAlertChooseTypeWithTitle:title detailText:detailtext tapButton:Handler];
//    }
//}





@end

