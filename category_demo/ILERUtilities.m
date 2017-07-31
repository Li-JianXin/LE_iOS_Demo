//
//  ILERUtilities.m
//  ILER_Category
//
//  Created by jianxin.li on 2017/4/20.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import "ILERUtilities.h"

CGFloat ILER_ScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

CGSize ILER_ScrrenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}
