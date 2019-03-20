//
//  BaseApi.h
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

FOUNDATION_EXPORT NSString *const NetworkRequestErrorDomain;

@interface BaseApi : YTKRequest

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id jsonData;


@end
