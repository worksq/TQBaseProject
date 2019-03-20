//
//  Animation.h
//  CABasicAnimation
//
//  Created by 童裳强 on 16/3/2.
//  Copyright © 2016年 ellemoi_alami-TQHelperTool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animation : NSObject
/**
 *  永久闪烁的动画
 *
 *  @param time 动画时间
 *
 *  @return
 */
+(CABasicAnimation *)opacityForever_Animation:(float)time;
/**
 *  有闪烁次数的动画
 *
 *  @param repeatTimes 重复次数
 *  @param time        动画时间
 *
 *  @return 
 */
+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;
/**
 *  横向移动
 *
 *  @param time   移动时间
 *  @param repeat 是否重复
 *  @param x      移动距离
 *
 *  @return 
 */
+(CABasicAnimation *)moveTime:(float)time Isrepeatcount:(BOOL)repeat X:(float)x;
/**
 *  纵向移动
 *
 *  @param time   移动时间
 *  @param repeat 是否重复
 *  @param y      移动距离
 *
 *  @return 
 */
+(CABasicAnimation *)moveTime:(float)time Isrepeatcount:(BOOL)repeat Y:(float)y;
/**
 *  缩放
 *
 *  @param Multiple      最大放大到多少倍
 *  @param orginMultiple 最小缩小到多少倍
 *  @param time          移动时间
 *  @param repeat        是否重复
 *
 *  @return 
 */
+(CABasicAnimation *)scale:(CGFloat)Multiple orgin:(CGFloat)orginMultiple durTimes:(float)time Isrepeatcount:(BOOL)repeat;
/**
 *  组合动画
 *
 *  @param animationAry 动画数组
 *  @param time         一次动画的时间
 *  @param repeatTimes  重复次数
 *
 *  @return 
 */
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes Isrepeatcount:(BOOL)repeat; //组合动画
/**
 *  路径动画
 *
 *  @param path        路径
 *  @param time        持续时间
 *  @param repeatTimes 重复次数
 *
 *  @return
 */
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes; //路径动画
/**
 *  点动画
 *
 *  @param point  移动的点
    @param time   持续时间
 *  @param repeat 是否重复
 *
 *  @return 
 */
+(CABasicAnimation *)movepoint:(CGPoint )point durTimes:(float)time Isrepeatcount:(BOOL)repeat; //点移动
/**
 *  旋转
 *
 *  @param dur         持续时间
 *  @param degree      旋转角度
 *  @param direction   方向
 *  @param repeatCount 重复次数
 *
 *  @return 
 */
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount Isrepeatcount:(BOOL)repeat; //旋转

+(CATransition *)transitionAnimation:(int)left;//切换场景的动画
+(CAKeyframeAnimation *)setPopAnimation;//返回弹簧donghua
@end
