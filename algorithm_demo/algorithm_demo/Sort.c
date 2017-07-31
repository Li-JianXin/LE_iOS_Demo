//
//  Sort.c
//  algorithm_demo
//
//  Created by lijianxin on 2017/7/31.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#include "Sort.h"

/**
 冒泡排序 最好的时间复杂度为 O(n) 最坏的时间复杂度为O (n^2)
 */
void bubble_sort(int arr[], int length) {
    printf("原始长度%d\n",length);
    for (int i = 0; i < length-1; i++) {
        printf("第%d轮\n",i+1);
        for (int j = 0; j < length-1; j++) {
            int preNum = arr[j];
            int nextNum = arr[j+1];
            if (preNum > nextNum) {
                int temp = preNum;
                arr[j] = nextNum;
                arr[j+1] = temp;
            }
        }
    }
}

/**
 快速排序 时间复杂度O(N*logN)
 */
void quick_sort(int arr[], int left, int right) {
    if (left < right) {
        int i = adjustArray(arr, left, right);
        // 递归
        quick_sort(arr, left, i - 1);
        quick_sort(arr, i + 1, right);
    }
}

// 挖坑填坑返回基准数位置
int adjustArray(int arr[], int left, int right) {
    
    int x = arr[left];  // 基准数
    int baseIndex = left;  // 坑位
    printf("\n基准位 %d  值：%d \n",baseIndex, x);
    
    while (left < right) {
        // 从右向左找比x小的数来填充x的位置
        while (left < right && arr[right] >= x) {
            right--;
        }
        if (left < right) {
            //将arr[right]填到arr[left]中，arr[right]就形成了一个新的坑
            arr[left] = arr[right];
            left++;
        }
        
        // 从左向右找比x大于或等于的数为填arr[right]的坑
        while (left < right && arr[left] < x) {
            left++;
        }
        if (left < right) {
            //将arr[left]填到arr[right]中，arr[left]就形成了一个新的坑
            arr[right] = arr[left];
            right--;
        }
    }
    // 退出时，left等于right 将x填到这个坑里
    arr[left] = x;
    return left;
}



