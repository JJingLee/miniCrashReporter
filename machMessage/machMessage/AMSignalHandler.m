//
//  AMSignalHandler.m
//  machMessage
//
//  Created by chiehchun on 2019/4/25.
//  Copyright © 2019 chiehchun. All rights reserved.
//

#import "AMSignalHandler.h"

@interface AMSignalHandler()
@end

void SignalExceptionHandler(int signal) {
    NSMutableString *signalInfo = [[NSMutableString alloc] init];
    [signalInfo appendString:@"Stack:\n"];
    
    NSArray<NSString *> *strs = NSThread.callStackSymbols;
    NSString *btString = [strs componentsJoinedByString:@"\n"];
    [signalInfo appendString:btString];
    
    [AMSignalHandler postSignal:signalInfo];
}

void InstallSignalHandler(void) {
    signal(SIGHUP, SignalExceptionHandler);
    signal(SIGINT, SignalExceptionHandler);
    signal(SIGQUIT, SignalExceptionHandler);
    
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

@implementation AMSignalHandler
+ (void)postSignal:(NSString*)signalInfo {
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSString *className = NSStringFromClass(root.class);
    
    [[AFHTTPSessionManager manager] POST:@"HTTP://127.0.0.1:8888" parameters:@{@"data" : signalInfo, @"rootViewController":className} progress:nil success:^(NSURLSessionTask *task, id responseObj){
        NSLog(@"response : %@", responseObj);
    } failure:^(NSURLSessionDataTask *task, NSError *err){
        
    }];
}
@end
