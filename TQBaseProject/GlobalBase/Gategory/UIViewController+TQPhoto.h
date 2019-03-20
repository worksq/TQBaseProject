//
//  UIViewController+TQPhoto.h
//  privacyvault
//
//  Created by Admin on 2017/11/17.
//  Copyright © 2017年 NiDEA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^photoBlock)(UIImage *photo);
@interface UIViewController (TQPhoto)
-(void)showCameraPhotoCanEdit:(BOOL)edit photo:(photoBlock)block;
-(void)showCameraCanEdit:(BOOL)edit photo:(photoBlock)block;
-(void)showPhotoCanEdit:(BOOL)edit photo:(photoBlock)block;
@end
