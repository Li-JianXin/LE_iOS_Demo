//
//  Sort.h
//  algorithm_demo
//
//  Created by lijianxin on 2017/7/31.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#ifndef Sort_h
#define Sort_h

#include <stdio.h>

/** 选择排序 */
void selection_sort(int arr[], int length);

/** 冒泡排序 */
void bubble_sort(int arr[], int length);

/** 快速排序 */
void quick_sort(int arr[], int left, int right);
// 挖坑填数 返回调整后基数的位置
int adjustArray(int arr[], int left, int right);

/** 插入排序 */
void insert_sort(int arr[], int length);

/**
 合并排序，将两个已经排序的数组合并成一个数组
 */
void mergeArray(int arrA[], int aLength, int arrB[], int bLength);

#endif /* Sort_h */
