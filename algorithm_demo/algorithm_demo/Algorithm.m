//
//  Algorithm.m
//  algorithm_demo
//
//  Created by lijianxin on 2017/8/3.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

- (NSArray *)mergeArrayA:(NSArray *)arrayA withArrayB:(NSArray *)arrayB {
    NSInteger arrayA_length = arrayA.count;
    NSInteger arrayB_length = arrayB.count;
    NSInteger length = arrayA_length + arrayB_length - 1;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:length];
    
    NSInteger i = 0 , j = 0 , k = 0;
    
    while (i < arrayA.count && j <arrayB.count) {
        if (arrayA[i] <= arrayB[j]) {
            array[k++] = arrayA[i++];
        } else {
            array[k++] = arrayB[j++];
        }
    }
    
    while (i < arrayA.count) {
        array[k++] = arrayA[i++];
    }
    
    while (j <arrayB.count) {
        array[k++] = arrayB[j++];
    }

    return array;
    
}

@end
