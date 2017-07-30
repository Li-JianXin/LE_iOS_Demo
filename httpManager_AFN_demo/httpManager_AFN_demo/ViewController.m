//
//  ViewController.m
//  httpManager_AFN_demo
//
//  Created by jianxin.li on 2016/10/18.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "ILERHTTPManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // example
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //
    //    [dict setValue:@0 forKey:@"userId"];
    //    [dict setValue:@224599 forKey:@"goodsStockDetailId"];
    //    [dict setValue:@1 forKey:@"isFilterSkuStock"];
    //    [dict setValue:@54334 forKey:@"goodsId"];
    //    [dict setValue:@0 forKey:@"salesId"];
    //    [dict setValue:@0 forKey:@"goodsSourceType"];
    //    [dict setValue:@"" forKey:@"auth"];
    //    [dict setValue:@0 forKey:@"programId"];
    //    [dict setValue:@"App_CategoryList_19" forKey:@"pageSourceMark"];
    
    // @"http://sandbox.api.m.m6go.com/iosapi/GoodsV2/GetPromotions.do"
    
    [dict setValue:@10 forKey:@"rows"];
    [dict setValue:@1 forKey:@"orderState"];
    [dict setValue:@"940880" forKey:@"userId"];
    [dict setValue:@"D628B5025C5FA87C6995262299DB6D4B" forKey:@"auth"];
    [dict setValue:@0 forKey:@"start"];
    
    [[ILERHTTPManager manager] POST:@"orderv2/OrderList.do" params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求：%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"错误：%@",error);
    }];
}




@end
