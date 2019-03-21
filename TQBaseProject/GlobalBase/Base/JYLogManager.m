//
//  JYLogManager.m
//  NewAquarium
//
//  Created by WORKSQ on 2018/11/24.
//  Copyright © 2018 TSQ. All rights reserved.
//s.source_files = 'TQBaseProject/GlobalBase/Base/*'

#import "JYLogManager.h"
#import "TQBaseProject.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation JYLogManager

+ (void)logInfo:(nullable NSString *)info{
    DDLogInfo(@"%@",info);
}

+ (void)logError:(nullable NSError *)error{
    DDLogError(@"JYError = %@",error);
}

+ (void)logError:(nullable NSError *)error markString:(nullable NSString *)mark{
    if (mark) {
        DDLogError(@"JYError = %@ 备注:%@",error,mark);
    }else{
        [self logError:error];
    }
}

+ (void)logWaring:(nullable NSString *)text{
    DDLogWarn(@"%@",text);
}

@end
