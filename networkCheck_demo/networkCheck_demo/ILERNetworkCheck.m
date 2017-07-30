//
//  ILERNetworkCheck.m
//  networkCheck_demo
//
//  Created by jianxin.li on 16/4/21.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ILERNetworkCheck.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface ILERNetworkCheck ()

@property (nonatomic,strong) Reachability *coon;

@end

@implementation ILERNetworkCheck

+ (instancetype)sharedNetworkCheck {
    return [[self alloc] init];
}

+ (void)initialize {
    static BOOL isInitialize = NO;
    if (!isInitialize) {
        instance = [[self alloc] init];
    }
}

static id instance = nil;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return instance;
}

/**
 *  检查网络是否连接
 *
 *  @return YES表示有网，NO表示无网
 */
+ (BOOL)isConnect {
    Reachability *reachForBaidu = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    Reachability *reachForQQ    = [Reachability reachabilityWithHostname:@"www.qq.com"];
    if(([reachForBaidu currentReachabilityStatus] == NotReachable)&&([reachForQQ currentReachabilityStatus] == NotReachable)) {
        return NO;
    } else {
        return YES;
    }
}

+ (NetworkStatus)currentNetworkState {
    Reachability *WIFI = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    if ([WIFI currentReachabilityStatus] != NotReachable) {
        //有WIFI
        return ReachableViaWiFi;
    } else {
        //无WIFI
        /*
         NotReachable     = 0,
         ReachableViaWiFi = 2,
         ReachableViaWWAN = 1,
         kReachableVia2G  = 3,
         kReachableVia3G  = 4,
         kReachableVia4G  = 5
         */
        if ([conn currentReachabilityStatus] != NotReachable) { //手机网络
            switch ([conn currentReachabilityStatus]) {
                case 1:
                    return ReachableViaWWAN;
                    break;
                case 3:
                    return kReachableVia2G;
                    break;
                case 4:
                    return kReachableVia3G;
                    break;
                case 5:
                    return kReachableVia4G;
                    break;
                default:
                    return ReachableViaWWAN;
                    break;
            }
        } else { //无网络
            return NotReachable;
        }
    }

}
@end
