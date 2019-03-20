//
//  BaseNavigationController.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseNavigationController.h"
#import "TQBaseProject.h"
#import <QMUIKit/UIImage+QMUI.h>

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize{
    // 设置导航栏背景颜色\文字颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barStyle = UIBarStyleDefault;
    
    [navBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : RGBA(51, 51, 51, 1), NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
    // 设置按钮文字颜色
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : RGBA(51, 51, 51, 1), NSFontAttributeName : UIFontMediumMake(16)}
                        forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : RGBA(51, 51, 51, 1), NSFontAttributeName : UIFontMediumMake(16)}
                        forState:UIControlStateHighlighted];
    [navBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:UIImage.new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 导航控制器的子控制器被push 的时候会调用
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"nav_back_b"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back_b"] forState:UIControlStateHighlighted];
        [btn setTitle:@"   " forState:UIControlStateNormal];
        [btn setTitle:@"   " forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, 35, 40);
        [btn addTarget:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = left1;
    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
#pragma mark 导航控制器的子控制器被pop[移除]的时候会调用
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)dismissToPre{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}



#pragma mark - autorotate

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [self.topViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.topViewController preferredStatusBarUpdateAnimation];
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
