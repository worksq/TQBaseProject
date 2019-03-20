//
//  JYCustomWaringView.m
//  test
//
//  Created by WORKSQ on 2018/10/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "JYCustomWaringView.h"
#import "TQBaseProject.h"
#import <Masonry/Masonry.h>

@interface JYCustomWaringView ()
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailText;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSArray <MMPopupItem *> *Items;
@end

@implementation JYCustomWaringView

- (instancetype)initWithTitle:(NSString *)title detailText:(NSString *)detailtext imageName:(NSString *)imageName MMPopupItems:(NSArray <MMPopupItem *> *)Items{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.title = title;
        self.detailText = detailtext;
        self.Items = Items;
        self.imageName = imageName;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.type = MMPopupTypeAlert;
    CGFloat viewW = 290;
    CGFloat topMargin = 27;
    CGFloat leftMargin = 26;
    
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(48);
    }];
    
    UIFont *titleFont = UIFontMake(16);
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.preferredMaxLayoutWidth = viewW - (leftMargin *2);
    titleLabel.numberOfLines = 0;
    titleLabel.text = self.title;
    titleLabel.textColor = RGBA(102, 102, 102, 1);
    titleLabel.font = titleFont;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(topMargin);
        make.left.equalTo(self).offset(leftMargin);
        make.right.equalTo(self).offset(-leftMargin);
    }];
    
    UIFont *detailFont = [UIFont systemFontOfSize:14];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1];
    detailLabel.font = detailFont;
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
    }];
    detailLabel.text = self.detailText;
    
    if (self.Items.count==1) {
        MMPopupItem *item = self.Items.firstObject;
        UIButton *btn = [self getbtn:item];
        btn.tag = 0;
        btn.backgroundColor = [UIColor colorWithRed:86/255.f green:105/255.f blue:225/255.f alpha:1];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(detailLabel.mas_bottom).offset(24);
            make.size.mas_equalTo(CGSizeMake(260, 44));
        }];
        
    }else if (self.Items.count >=2){
        MMPopupItem *item1 = self.Items.firstObject;
        UIButton *btn1 = [self getbtn:item1];
        btn1.tag = 0;
        [self addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(leftMargin);
            make.top.equalTo(detailLabel.mas_bottom).offset(24);
            make.size.mas_equalTo(CGSizeMake(110, 44));
        }];
        
        MMPopupItem *item2 = self.Items[1];
        UIButton *btn2 = [self getbtn:item2];
        btn2.tag = 1;
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-leftMargin);
            make.top.equalTo(btn1);
            make.size.mas_equalTo(CGSizeMake(110, 44));
        }];
    }
    CGFloat margin = self.Items.count>0?90:30;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(viewW);
        make.bottom.equalTo(detailLabel).offset(margin);
    }];
    
}

- (UIButton *)getbtn:(MMPopupItem *)item{
    
    UIColor *color = [UIColor blackColor];
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
    btn.titleLabel.font = UIFontMake(16);
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


+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler{
    if (btnTitle == nil) {
        btnTitle = @"确定";
    }
    NSArray *items = @[MMItemMake(btnTitle, MMItemTypeHighlight, Handler)];
    JYCustomWaringView *view = [[JYCustomWaringView alloc] initWithTitle:title detailText:detailtext imageName:imageName MMPopupItems:items];
    [view show];
    return view;
    
}

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext imageName:(NSString *)imageName cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler{
    if (btn1Title == nil) {
        btn1Title = @"取消";
    }
    if (btn2Title == nil) {
        btn2Title = @"确定";
    }
    NSArray *items = @[MMItemMake(btn1Title, MMItemTypeNormal, nil),MMItemMake(btn2Title, MMItemTypeHighlight, Handler)];
    JYCustomWaringView *view = [[JYCustomWaringView alloc] initWithTitle:title  detailText:detailtext imageName:imageName MMPopupItems:items];
    [view show];
    return view;
    
}

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext cancelBtnTitle:(NSString *)btn1Title commitBtnTitle:(NSString *)btn2Title tapButton:(MMPopupItemHandler)Handler{
    return [self showWaringViewWithTitle:title detailText:detailtext imageName:@"JYCustomWaringView_1" cancelBtnTitle:btn1Title commitBtnTitle:btn2Title tapButton:Handler];
}

+ (instancetype)showWaringViewWithTitle:(NSString *)title detailText:(NSString *)detailtext buttonTitle:(NSString *)btnTitle tapButton:(MMPopupItemHandler)Handler{
    return [self showWaringViewWithTitle:title detailText:detailtext imageName:@"JYCustomWaringView_1" buttonTitle:btnTitle tapButton:Handler];
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
