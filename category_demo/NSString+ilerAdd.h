//
//  NSString+ilerAdd.h
//  ILER_Category
//
//  Created by jianxin.li on 2017/4/19.
//  Copyright © 2017年 m6go.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (ilerAdd)

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 */
- (CGFloat)widthForFont:(UIFont *)font;
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


@end
