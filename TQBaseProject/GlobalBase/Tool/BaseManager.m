//
//  BaseManager.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseManager.h"

@implementation BaseManager

+ (instancetype)sharedManager{
    static id tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

@end
