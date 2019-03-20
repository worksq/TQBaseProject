//
//  JYCustomHudView.h
//  JYWave
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, JYCustomHudViewStlye) {
    JYCustomHudViewIndicator,
    JYCustomHudViewAlert,
};

@interface JYCustomHudView : UIView
- (instancetype)initWithText:(NSString *)text stlye:(JYCustomHudViewStlye)stlye;
@end
