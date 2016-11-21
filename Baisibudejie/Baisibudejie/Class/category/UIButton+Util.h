//
//  UIButton+Util.h
//  baisibudesister
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)
//创建按钮的遍历方法
+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName highlightBgImageName:(NSString *)highlightBgImageName target:(id)target action:(SEL)action;


@end
