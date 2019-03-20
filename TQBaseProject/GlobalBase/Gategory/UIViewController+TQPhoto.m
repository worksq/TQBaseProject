//
//  UIViewController+TQPhoto.m
//  privacyvault
//
//  Created by Admin on 2017/11/17.
//  Copyright © 2017年 NiDEA. All rights reserved.
//

#import "UIViewController+TQPhoto.h"
#import "objc/runtime.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>


static  BOOL canEdit = NO;
static  char blockKey;

@interface UIViewController()<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy)photoBlock photoBlock;

@end

@implementation UIViewController (TQPhoto)

#pragma mark-set
-(void)setPhotoBlock:(photoBlock)photoBlock
{
    objc_setAssociatedObject(self, &blockKey, photoBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark-get
- (photoBlock )photoBlock
{
    return objc_getAssociatedObject(self, &blockKey);
}

-(void)showCameraPhotoCanEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    self.photoBlock = [block copy];
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    sheet.tag = 84692;
    [sheet showInView:self.view];
}

-(void)showCameraCanEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    self.photoBlock = [block copy];
    [self ShowCamera];
}

-(void)showPhotoCanEdit:(BOOL)edit photo:(photoBlock)block
{
    canEdit = edit;
    self.photoBlock = [block copy];
    [self ShowPhoto];
    
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==84692)
    {
       
        if (buttonIndex==0) {
            //相机权限
            [self ShowCamera];
           
        }else  if (buttonIndex==1){
            //相册权限
            [self ShowPhoto];
           
        }
    }
}

-(void)ShowCamera{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted) {
            return;
        } else if (authStatus == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *AlertVc = [UIAlertController alertControllerWithTitle:@"没有权限" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设置" style:0 handler:^(UIAlertAction * _Nonnull action) {
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
            [AlertVc addAction:action1];
            [AlertVc addAction:action2];
            [self presentViewController:AlertVc animated:YES completion:nil];
            return;
        } else if (authStatus == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self ShowCameraFromPhoto:NO];
            });
           
        } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    // 用户接受
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [self ShowCameraFromPhoto:NO];
                    });
                  
                }
            }];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"未检测到您的摄像头" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(void)ShowPhoto{
    // 相册授权判断
    __weak typeof(self) weakself = self;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 此应用程序没有被授权访问的照片数据。可能是家长控制权限。
//        NSLog(@"因为系统原因, 无法访问相册");
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝访问相册
        UIAlertController *AlertVc = [UIAlertController alertControllerWithTitle:@"没有权限" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设置" style:0 handler:^(UIAlertAction * _Nonnull action) {
            // 无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
        [AlertVc addAction:action1];
        [AlertVc addAction:action2];
        [self presentViewController:AlertVc animated:YES completion:nil];
        return;
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许访问相册
        // 放一些使用相册的代码
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself ShowCameraFromPhoto:YES];
        });
        
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                // 放一些使用相册的代码
                dispatch_async(dispatch_get_main_queue(), ^{
                     [weakself ShowCameraFromPhoto:YES];
                });
               
            }
        }];
    }
}

//触发事件：拍照 相册
- (void)ShowCameraFromPhoto:(BOOL)photo
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = canEdit; //是否可编辑
    if (photo) {
        //相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        //相机拍照
        //判断是否可以打开照相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //摄像头
            //UIImagePickerControllerSourceTypeSavedPhotosAlbum:相机胶卷
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else { //否则打开照片库
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
             [self presentViewController:picker animated:YES completion:nil];
        }];
    }else{
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//触发事件：录像
- (void)addVideo
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = canEdit;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 10; //录像最长时间
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前设备不支持录像功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    //跳转到拍摄页面
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:picker animated:YES completion:nil];
        }];
    }else{
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

//拍摄完成后要执行的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image;
        if ([picker allowsEditing]){
            //编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if (self.photoBlock) {
            self.photoBlock(image);
        }
    } else if ([mediaType isEqualToString:@"public.movie"]) {
//        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //NSData *videlData = [NSData dataWithContentsOfURL:videoURL];
//        NSLog(@"%@",videoURL);
    
       
    }
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.photoBlock = nil;
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.photoBlock = nil;
}





@end
