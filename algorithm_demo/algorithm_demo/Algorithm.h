//
//  Algorithm.h
//  algorithm_demo
//
//  Created by lijianxin on 2017/8/3.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Algorithm : NSObject


/** 
 合并排序，将两个已经排序的数组合并成一个数组
 */
- (NSArray *)mergeArrayA:(NSArray *)arrayA withArrayB:(NSArray *)arrayB;

/**
 折半查找
 */
- (void)binarySearchInArray:(NSArray *)array withNumber:(NSNumber *)number;

@end
