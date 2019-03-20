//
//  BaseTabBaarController.m
//  NewAquarium
//
//  Created by WORKSQ on 2019/3/8.
//  Copyright © 2019 TSQ. All rights reserved.
//

#import "BaseTabBaarController.h"

@interface BaseTabBaarController ()

@end

@implementation BaseTabBaarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.selectedViewController preferredStatusBarUpdateAnimation];
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
