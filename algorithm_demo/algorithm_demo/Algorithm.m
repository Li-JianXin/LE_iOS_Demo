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

/**
折半查找法思想：
在有序表中，把待查找数据值与查找范围的中间元素值进行比较，会有三种情况出现：
1）     待查找数据值与中间元素值正好相等，则放回中间元素值的索引。
2）     待查找数据值比中间元素值小，则以整个查找范围的前半部分作为新的查找范围，执行1），直到找到相等的值。
3）     待查找数据值比中间元素值大，则以整个查找范围的后半部分作为新的查找范围，执行1），直到找到相等的值
4）     如果最后找不到相等的值，则返回错误提示信息。

按照二叉树来理解：中间值为二叉树的根，前半部分为左子树，后半部分为右子树。折半查找法的查找次数正好为该值所在的层数。等概率情况下，约为    log2(n+1)-1
 */
- (void)binarySearchInArray:(NSArray *)array withNumber:(NSNumber *)number {
    NSInteger left = 0;
    NSInteger right = array.count - 1;
    NSInteger middle = 0;
    
    while (left <= right) {
        middle = (left + right) / 2;
        
        if (array[middle] > number) {
            right = middle - 1;
        }
        
        if (number > array[middle]) {
            left = middle + 1;
        }
        
        if (number == array[middle]) {
            NSLog(@"找到number: %@  索引是:%ld",number, middle);
            break;
        }

    }
}

@end
