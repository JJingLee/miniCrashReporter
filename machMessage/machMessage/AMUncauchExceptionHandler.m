//
//  AMUncauchExceptionHandler.m
//  machMessage
//
//  Created by chiehchun on 2019/4/25.
//  Copyright © 2019 chiehchun. All rights reserved.
//

#import "AMUncauchExceptionHandler.h"


@interface AMUncauchExceptionHandler()

@end

void HandleException(NSException *exception)
{
    // 異常callStack
    NSArray *stackArray = [exception callStackSymbols];
    // 異常原因
    NSString *reason = [exception reason];
    // 異常名稱
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    NSLog(@"%@", exceptionInfo);
    [AMUncauchExceptionHandler postException:exceptionInfo];
}

void InstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
}

@implementation AMUncauchExceptionHandler

+ (void)postException:(NSString*)exceptionInfo {
    //上報資訊
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSString *className = NSStringFromClass(root.class);
    
    [[AFHTTPSessionManager manager] POST:@"HTTP://127.0.0.1:8888" parameters:@{@"data" : exceptionInfo, @"rootViewController":className} progress:nil success:^(NSURLSessionTask *task, id responseObj){
        NSLog(@"response : %@", responseObj);
    } failure:^(NSURLSessionDataTask *task, NSError *err){
        
    }];
}

@end
