//
//  AMUncauchExceptionHandler.h
//  machMessage
//
//  Created by chiehchun on 2019/4/25.
//  Copyright © 2019 chiehchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
void InstallUncaughtExceptionHandler(void);
@interface AMUncauchExceptionHandler : NSObject
+ (void)postException:(NSString*)exceptionInfo;
@end

NS_ASSUME_NONNULL_END
