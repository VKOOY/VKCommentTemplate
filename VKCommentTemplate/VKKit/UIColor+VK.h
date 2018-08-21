//
//  UIColor+VK.h
//  VKOOY_iOS
//
//  Created by Mike on 15/8/21.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>

//  RGB颜色
#define VKColorRGB(r,g,b)           [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define VKColorRGBA(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define VKRandomColor VKColorRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

//  HexColor
#define HexColor(X)                 [UIColor colorWithRed:((float)((X & 0xFF0000) >> 16))/255.0 green:((float)((X & 0xFF00) >> 8))/255.0 blue:((float)(X & 0xFF))/255.0 alpha:1.0]
#define HexColorA(X,A)              [UIColor colorWithRed:((float)((X & 0xFF0000) >> 16))/255.0 green:((float)((X & 0xFF00) >> 8))/255.0 blue:((float)(X & 0xFF))/255.0 alpha:A]


@interface UIColor (VK)

/** 该颜色色差后的颜色 eg. 差别0.618 透明0.9 */
-(UIColor *)je_Abe:(CGFloat)abe Alpha:(CGFloat)Alpha;

/** 渐变 */
+(UIColor*)je_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

+ (instancetype)colorWithHexString:(NSString *)hexStr;




/**
 *  16进制转颜色，格式：0xecedec
 *
 *  @param rgbValue 比如：0xecedec
 *  @param alpha    透明度：0.0-1.0
 *
 *  @return <#return value description#>
 */
+ (instancetype)colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

/**
 *  字符串转颜色，格式：#ececec
 *
 *  @param htmlColor 比如：#ecedec
 *  @param alpha     透明度：0.0-1.0
 *
 *  @return <#return value description#>
 */
+ (instancetype)colorWithHexString:(NSString *)htmlColor alpha:(CGFloat)alpha;


/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;


/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(CGFloat)alpha;



@end
