//
//  ViewController.m
//  autoLayout_demo
//
//  Created by jianxin.li on 16/5/11.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAutoLayout_VFL1];
    [self addAutoLayout_Test1];
}

- (void)addAutoLayout_VFL1 {
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    // 禁止将AutoresizingMask默认设置转为约束
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // VFL实现AutoLayout
    
    // 间距
    NSNumber *margin = @20;
    NSNumber *height = @30;
    
    NSDictionary *views   = NSDictionaryOfVariableBindings(blueView,redView);
    NSDictionary *margins = NSDictionaryOfVariableBindings(margin,height);
    
    // 添加水平方向约束
    NSString *vfl_h = @"H:|-margin-[blueView]-margin-[redView(==blueView)]-margin-|";
    NSArray *constraints_h = [NSLayoutConstraint constraintsWithVisualFormat:vfl_h options:kNilOptions metrics:margins views:views];
    [self.view addConstraints:constraints_h];
    
    // 添加垂直方向约束
    NSString *vfl_v_b = @"V:|-20-[blueView(height)]";
    NSArray *constraints_v_b = [NSLayoutConstraint constraintsWithVisualFormat:vfl_v_b options:kNilOptions metrics:margins views:views];
    [self.view addConstraints:constraints_v_b];
    
    NSString *vfl_v_r = @"V:|-20-[redView(height)]";
    NSArray *constraints_v_r = [NSLayoutConstraint constraintsWithVisualFormat:vfl_v_r options:kNilOptions metrics:margins views:views];
    [self.view addConstraints:constraints_v_r];
}


/** 绿色 宽300 高100 距离父控件 上80、左20 */
- (void)addAutoLayout_Test1 {
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    // 禁止将AutoresizingMask默认设置转为约束
    greenView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 宽度约束(对应一条线)

   
    /**
     param view1      要约束的控件
     param attr1      约束的类型
     param relation   与参照控制之间的关系
     param view2      参照的控件
     param attr2      约束的类型
     param multiplier 乘数
     param c          常量
     */
    // 宽度约束：300
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:300];
    
    // 高度约束：100
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:100];
    
    // 位置约束 距离父控件 上、左边距各为20
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    
    // 添加约束
    [greenView addConstraint:widthConstraint];
    [greenView addConstraint:heightConstraint];
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:leftConstraint];
}

/** 蓝色 宽高为父控件一半 居父控件中心 */
- (void)addAutoLayout_Test2 {
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    // 禁止将AutoresizingMask默认设置转为约束
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 宽度约束：父控件一半
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    
    // 高度约束：父控件一半
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0];
    
    // 位置约束: 居中
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    /*
     [self.view addConstraint:widthConstraint];
     [self.view addConstraint:heightConstraint];
     [self.view addConstraint:centerXConstraint];
     [self.view addConstraint:centerYConstraint];
     */
    
    [self.view addConstraints:@[widthConstraint,heightConstraint,centerXConstraint,centerYConstraint]];
}

/** 蓝色 红色 视图布局 */
- (void)addAutoLayout_Test3 {
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    // 禁止将AutoresizingMask默认设置转为约束
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 蓝色视图
    // 高度约束：100
    NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:100];
    [blueView addConstraint:heightConstraint1];
    
    // 左边约束:20
    NSLayoutConstraint *leftConstraint1 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20];
    [blueView.superview addConstraint:leftConstraint1];
    
    // 右边约束:20
    NSLayoutConstraint *rightConstraint1 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20];
    [self.view addConstraint:rightConstraint1];
    
    // 顶部约束:20
    NSLayoutConstraint *topConstraint1 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    [self.view addConstraint:topConstraint1];
    
    // 红色视图
    // 高度约束：同蓝色一样
    NSLayoutConstraint *heightConstraint2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraint:heightConstraint2];
    // 宽度约束：蓝色一半
    NSLayoutConstraint *widthConstraint2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [self.view addConstraint:widthConstraint2];
    
    // 顶部约束：距离蓝色20
    NSLayoutConstraint *topConstraint2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20];
    [self.view addConstraint:topConstraint2];
    
    // 中心点约束
    NSLayoutConstraint *centerXConstraint2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:centerXConstraint2];
    
}

/** VFL实现蓝色控件 居上左右 20 */
- (void)addAutoLayout_VFL2 {
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    // 禁止将AutoresizingMask默认设置转为约束
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // VFL实现AutoLayout
    // 添加水平方向约束
    NSDictionary *views = @{@"blueView":blueView};
    NSString *vfl_h = @"H:|-20-[blueView]-20-|";
    NSArray *constraints_h = [NSLayoutConstraint constraintsWithVisualFormat:vfl_h options:kNilOptions metrics:nil views:views];
    [self.view addConstraints:constraints_h];
    
    // 添加垂直方向约束
    NSString *vfl_v = @"V:|-20-[blueView(40)]";
    NSArray *constraints_v = [NSLayoutConstraint constraintsWithVisualFormat:vfl_v options:kNilOptions metrics:nil views:views];
    [self.view addConstraints:constraints_v];
}





@end
