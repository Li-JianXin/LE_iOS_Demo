//
//  main.m
//  algorithm_demo
//
//  Created by lijianxin on 2017/7/31.
//  Copyright © 2017年 jianxin.li. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Sort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int list[10] = {95, 45, 15, 78, 84, 51, 24, 12, 3, 62};
        printf("排序后前\n");
        for (int i = 0; i < 10; i++) {
            printf("%d ", list[i]);
        }
        printf("\n排序后\n");
        bubble_sort(list, 10);
        for (int i = 0; i < 10; i++) {
            printf("%d ", list[i]);
        }
        printf("\n");
        
    }
    return 0;
}

