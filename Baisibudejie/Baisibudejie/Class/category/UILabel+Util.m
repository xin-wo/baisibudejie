//
//  UILabel+Util.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

+ (UILabel *)createLabel:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    if (title) {
        label.text = title;
    }
    if (font) {
        label.font = font;
    }
    if (color) {
        label.textColor = color;
    }
    return  label;
}


@end
