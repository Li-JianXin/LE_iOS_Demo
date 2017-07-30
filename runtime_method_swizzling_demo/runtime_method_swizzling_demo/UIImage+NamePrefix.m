//
//  UIImage+NamePrefix.m
//  runtime_method_swizzling_demo
//
//  Created by jianxin.li on 16/6/28.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "UIImage+NamePrefix.h"
#import <objc/runtime.h>

@implementation UIImage (NamePrefix)

+ (UIImage *)prefixImageNamed:(NSString *)name {
    NSString *prefixName = [@"new_" stringByAppendingString:name];
    return [self prefixImageNamed:prefixName];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = object_getClass([self class]);
        
        SEL oriSEL = @selector(imageNamed:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        SEL cusSEL = @selector(prefixImageNamed:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        // IMP(Implementation)指向一个方法实现的指针
        // 先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL isAddSuccess = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        
        if (isAddSuccess) {
            // 添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(cusMethod), method_getTypeEncoding(oriMethod));
        } else {
            // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
}

@end
