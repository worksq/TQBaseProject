//
//  Animation.m
//  CABasicAnimation
//
//  Created by 童裳强 on 16/3/2.
//  Copyright © 2016年 ellemoi_alami-TQHelperTool. All rights reserved.
//

#import "Animation.h"

@implementation Animation
+(CABasicAnimation *)opacityForever_Animation:(float)time //永久闪烁的动画
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time //有闪烁次数的动画
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.4];
    animation.repeatCount=repeatTimes;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=YES;
    return  animation;
}

+(CABasicAnimation *)moveTime:(float)time Isrepeatcount:(BOOL)repeat X:(float)x //横向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    NSNumber *num = [NSNumber numberWithFloat:x];
    animation.toValue=num;
    animation.duration=time;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
        animation.autoreverses=YES;
    }
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)moveTime:(float)time Isrepeatcount:(BOOL)repeat Y:(float )y //纵向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    NSNumber *num = [NSNumber numberWithFloat:y];
    animation.toValue=num;
    animation.duration=time;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
        animation.autoreverses=YES;
    }
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation *)scale:(CGFloat)Multiple orgin:(CGFloat)orginMultiple durTimes:(float)time Isrepeatcount:(BOOL)repeat //缩放
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    NSNumber *num1 = [NSNumber numberWithFloat:orginMultiple];
    animation.fromValue=num1;
    NSNumber *num = [NSNumber numberWithFloat:Multiple];
    animation.toValue=num;
    animation.duration=time;
    animation.autoreverses=YES;
//    animation.repeatCount=repeatTimes;//重复次数
    
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
        animation.autoreverses=YES;
    }
    return animation;
}

+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes Isrepeatcount:(BOOL)repeat//组合动画
{
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
//        animation.autoreverses=YES;
    }
    return animation;
}

+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes //路径动画
{
//    CGMutablePathRef path1 = CGPathCreateMutable();
//    UIBezierPath* theBezierPath = [UIBezierPath bezierPath];
//    [theBezierPath moveToPoint: CGPointMake(startX, startY)];
//    [theBezierPath addCurveToPoint: CGPointMake(endX, endY) controlPoint1: CGPointMake(startX-100,startY-20) controlPoint2: CGPointMake(endX+100, endY+W6(40))];
//    [theBezierPath closePath];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    return animation;
}

+(CABasicAnimation *)movepoint:(CGPoint )point durTimes:(float)time Isrepeatcount:(BOOL)repeat //点移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.duration=time;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
        animation.autoreverses=YES;
    }
    return animation;
}

+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount Isrepeatcount:(BOOL)repeat //旋转
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);//旋转沿着哪个方向旋转
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    if (repeat) {
        animation.repeatCount=FLT_MAX;
        animation.autoreverses=NO;
    }
    animation.delegate= self;
    
    return animation;
}

/*
 CATransition转场动画。
 1      pageCurl            向上翻一页
 2      pageUnCurl          向下翻一页
 3      rippleEffect        滴水效果
 4      suckEffect          收缩效果，如一块布被抽走
 5      cube                立方体效果
 6      oglFlip             上下翻转效果
 7      fade                交叉淡化过度
 8      push                新视图把就视图推过去
 9      moveIn              新视图移到旧视图上面
 10     revrel              将旧视图移开，显示下面的新视图
 @"cameraIrisHollowClose ";//106镜头关
 @"cameraIrisHollowOpen ";//107//镜头开
 
 */
+(CATransition *)transitionAnimation:(int)left{
    
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";  //动画过渡类型
    if (left==1) {
        transition.subtype = kCATransitionFromLeft; //动画过度方向
    }else{
        transition.subtype = kCATransitionFromRight; //动画过度方向
    }
    
    transition.repeatCount = 1; //动画重复次数，最大次数HUGE_VALL
    transition.duration = 0.8f;    //动画持续时间
    return transition;
    //    [self.redView.layer addAnimation:transition forKey:nil];
}

+(CAKeyframeAnimation *)setPopAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return popAnimation;
}

@end
