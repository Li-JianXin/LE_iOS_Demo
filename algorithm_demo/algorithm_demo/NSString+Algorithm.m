//
//  NSString+Algorithm.m
//  algorithm_demo
//
//  Created by lijianxin on 2017/8/1.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#import "NSString+Algorithm.h"

@implementation NSString (Algorithm)

- (NSString *)replacesBlankWithString:(NSString *)string {
    if (!string) {
        return nil;
    }
    
    NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:string];
    return newString;
}

@end
