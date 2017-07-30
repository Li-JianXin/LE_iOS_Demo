//
//  ILERHTTPSessionManager.m
//  httpManager_AFN_demo
//
//  Created by jianxin.li on 2016/10/18.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ILERHTTPSessionManager.h"

@implementation ILERHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        [self setHttpHeader];
    }
    return self;
}

- (void)setHttpHeader {
    /*
     AFSecurityPolicy 封装了证书验证的过程，让用户可以轻易使用，除了去系统信任CA机构列表验证， 还支持SSL Pinning方式的验证
     AFSSLPinningModeNone  这个模式表示不做SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。
     若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
     */
    
    // 使用自签证书来访问HTTPS
    self.securityPolicy = [AFSecurityPolicy defaultPolicy];
    self.securityPolicy.allowInvalidCertificates = YES;
    
    // 设置请求超时时间
    self.requestSerializer.timeoutInterval = 30.f;
    
    //    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 设置请求序列化器
    self.requestSerializer  = [AFJSONRequestSerializer serializer];
    /**设置相应的缓存策略*/
    self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    /** ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓业务需求↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
    [self.requestSerializer setValue:@"7fac2982671666cddfffc7601b3c5210" forHTTPHeaderField:@"sign"];
    [self.requestSerializer setValue:@"O1vguUGqWHg;c=2;r=485596966" forHTTPHeaderField:@"X-Tingyun-Id"];
    [self.requestSerializer setValue:@"3.1.1" forHTTPHeaderField:@"version"];
    [self.requestSerializer setValue:@"iPod7,1" forHTTPHeaderField:@"equipmentModel"];
    [self.requestSerializer setValue:@"56C03BEC-3BB9-4F68-A1E9-E9BA90CD7E3D" forHTTPHeaderField:@"IDFA"];
    // 网络状态
    [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"netTranslateType"];
    [self.requestSerializer setValue:@"D628B5025C5FA87C6995262299DB6D4B" forHTTPHeaderField:@"appAuth"];
    [self.requestSerializer setValue:@"zh-Hans;q=1" forHTTPHeaderField:@"Accept-Language"];
    [self.requestSerializer setValue:@"8.40" forHTTPHeaderField:@"equipmentOsVersion"];
    
    [self.requestSerializer setValue:@"MBuyGo/3.1.1 (iPod touch; iOS 8.4.1; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
    [self.requestSerializer setValue:@"dce7c4228fa175e173429e9787a4b07d1daf5423" forHTTPHeaderField:@"mobileSN"];
    [self.requestSerializer setValue:@"AppleStore" forHTTPHeaderField:@"SetupChannel"];
    [self.requestSerializer setValue:@"940880" forHTTPHeaderField:@"appUserId"];
    /** ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑业务需求↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
    
    // 设置响应序列化器
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
    
    // 设置 APP版本  安装渠道  设备类型  设备允许系统  设备UDID(使用的是openUDID)  IDFA
    //    [self.requestSerializer setValue:[MLGHelp getAPPVersion]
    //                  forHTTPHeaderField:@"version"];
    //    [self.requestSerializer setValue:[MLGHelp getAPPSetupChannel]
    //                  forHTTPHeaderField:@"SetupChannel"];
    //    [self.requestSerializer setValue:[MLGHelp getDeviceTypeName]
    //                  forHTTPHeaderField:@"equipmentModel"];
    //    [self.requestSerializer setValue:[MLGHelp getDeviceSystemVersion]
    //                  forHTTPHeaderField:@"equipmentOsVersion"];
    //    [self.requestSerializer setValue:[MLGHelp getDeviceOpenUDID]
    //                  forHTTPHeaderField:@"mobileSN"];
    //    [self.requestSerializer setValue:[MLGHelp getDeviceIDFAString]
    //                  forHTTPHeaderField:@"IDFA"];
    //    // 网络状态
    //    [self.requestSerializer setValue:[MLGHelp getNetTranslateType] forHTTPHeaderField:@"netTranslateType"];
    //    [self.requestSerializer setValue:[MLGHelp getMCCandMNC] forHTTPHeaderField:@"networkOperator"];
    //
    //    // 登录
    //    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@", [Utility getUserID]] forHTTPHeaderField:@"appUserId"];
    //    [self.requestSerializer setValue:[Utility getUserAuth] forHTTPHeaderField:@"appAuth"];
    
}


@end
