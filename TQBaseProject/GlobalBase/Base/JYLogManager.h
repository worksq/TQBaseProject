//
//  JYLogManager.h
//  NewAquarium
//
//  Created by WORKSQ on 2018/11/24.
//  Copyright © 2018 TSQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYLogManager : NSObject
+ (void)logWaring:(nullable NSString *)text;
+ (void)logError:(nullable NSError *)error;
+ (void)logError:(nullable NSError *)error markString:(nullable NSString *)mark;
+ (void)logInfo:(nullable NSString *)info;

@end

NS_ASSUME_NONNULL_END
