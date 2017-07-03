//
//  Accord.m
//  _objc_msgForward_demo
//
//  Created by jianxin.li on 2017/7/3.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import "Accord.h"

@implementation Accord

- (void)start:(id)condition {
    NSLog(@"Accord start : %@",condition);
}

- (void)invocationStart:(id)condition {
    NSLog(@"Invocation Accord start : %@",condition);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [self performSelector:anInvocation.selector withObject:nil];
}

@end
