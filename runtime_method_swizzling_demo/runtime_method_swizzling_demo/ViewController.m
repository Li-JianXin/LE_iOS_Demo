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
@property (nonatomic, strong) UIImageView *imageView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    int x = arc4random() % 11;
    x = 1;
    UIImage *image1 = [UIImage imageNamed:[@"image" stringByAppendingString:[NSString stringWithFormat:@"%d",x]]];
    CGSize image1Size = image1.size;
    CGRect imageView1Frame = self.imageView1.frame;
    imageView1Frame.size = image1Size;
    self.imageView1.image = image1;
    self.imageView1.frame = imageView1Frame;
    self.imageView1.center = self.view.center;
    if (!self.imageView1.superview) {
        [self.view addSubview:self.imageView1];
    }
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [UIImageView new];
    }
    return _imageView1;
}

@end
