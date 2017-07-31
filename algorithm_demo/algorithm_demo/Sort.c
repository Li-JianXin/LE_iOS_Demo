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
