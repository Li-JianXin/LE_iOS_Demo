//
//  NSData+ilerAdd.m
//  ILER_Category
//
//  Created by jianxin.li on 2017/4/20.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import "NSData+ilerAdd.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (ilerAdd)

- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
