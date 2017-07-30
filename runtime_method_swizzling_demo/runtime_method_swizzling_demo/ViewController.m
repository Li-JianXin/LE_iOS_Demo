//
//  ViewController.m
//  runtime_method_swizzling_demo
//
//  Created by jianxin.li on 16/6/28.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+NamePrefix.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    UIImage *image1 = [UIImage imageNamed:@"image1"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    imageView1.center = self.view.center;
    [self.view addSubview:imageView1];
}

@end
