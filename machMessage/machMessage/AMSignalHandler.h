//
//  AMSignalHandler.h
//  machMessage
//
//  Created by chiehchun on 2019/4/25.
//  Copyright © 2019 chiehchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
void InstallSignalHandler(void);
@interface AMSignalHandler : NSObject
+ (void)postSignal:(NSString*)signalInfo;
@end

NS_ASSUME_NONNULL_END
