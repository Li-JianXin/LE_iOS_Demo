//
//  ViewController.m
//  _objc_msgForward_demo
//
//  Created by jianxin.li on 2017/7/3.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "Civic.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    Civic *civic = [[Civic alloc] init];
    [civic performSelector:@selector(start:) withObject:@"加价八千"];
}





@end
