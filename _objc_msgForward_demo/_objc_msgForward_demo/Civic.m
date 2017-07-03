//
//  Civic.m
//  _objc_msgForward_demo
//
//  Created by jianxin.li on 2017/7/3.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import "Civic.h"
#import <objc/runtime.h>
#import "Accord.h"

@interface Civic ()

@property (nonatomic, strong) Accord *accord;

@end

@implementation Civic

- (instancetype)init {
    if (self = [super init]) {
        _accord = [Accord new];
    }
    return self;
}

/**
 消息转发
 */

// 1.Method resolution
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 可以在这里提供一个函数实现
    class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "@@:");
    BOOL result = [super resolveInstanceMethod:sel];
    result = YES;
    return result;
}


// 动态增加的方法
id dynamicMethodIMP(id self, SEL _cmd, NSString *string) {
    NSLog(@"%s:动态添加的方法",__FUNCTION__);
    NSLog(@"%@ start : %@",NSStringFromClass([self class]), string);
    return @"1";
}

// 2.Fast forwarding
// 当1未实现时 会移到这一步 可以将此消息转发给其他对象
- (id)forwardingTargetForSelector:(SEL)aSelector {
    id result = [super forwardingTargetForSelector:aSelector];
    result = self.accord;
    return result;
}

// 3.Normal forwarding
// 获取函数的参数和返回值类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 当此方法返回nil时 程序挂掉
    id result = [super methodSignatureForSelector:aSelector];
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];  // 类型编码 
    result = methodSignature;
    return result;
}

// 当methodSignatureForSelector:方法返回函数签名时，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    anInvocation.selector = @selector(invocationStart:);
    [self.accord forwardInvocation:anInvocation];
}

/**
 消息转发失败，程序挂掉
 */
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    [super doesNotRecognizeSelector:aSelector];
}



@end
