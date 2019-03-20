//
//  GloballBaseController.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseController.h"


@interface BaseController ()<QMUINavigationControllerAppearanceDelegate,QMUICustomNavigationBarTransitionDelegate>

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)setLeftBarItemWithImageName:(NSString *)name action:(SEL)sel{
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setLeftBarItemWithTitle:(NSString *)name action:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setRightBarItemWithImageName:(NSString *)name action:(SEL)sel{
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightBarItemWithTitle:(NSString *)name action:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addBackItemWithAction:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"nav_back_b"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_back_b"] forState:UIControlStateHighlighted];
    [btn setTitle:@"   " forState:UIControlStateNormal];
    [btn setTitle:@"   " forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 35, 40);
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = left1;
}

- (void)setBackBarItemWithTitle:(NSString *)name action:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.backBarButtonItem = item;
}

- (void)setBackBarItemWithImageName:(NSString *)name action:(SEL)sel{
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.backBarButtonItem = item;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc{
    NSLog(@"%s--%@",__func__,self.class);
}



@end
