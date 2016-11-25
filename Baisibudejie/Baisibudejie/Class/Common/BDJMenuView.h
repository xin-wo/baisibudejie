//
//  BDJMenuView.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MenuType){
    MenuTypeEssence = 1 << 0, //精华
    
    MenuTypeNews = 1 << 1 //最新
    
};


@class BDJMenuView;

@protocol BDJMenuViewDelegate <NSObject>

//点击了第几个按钮
- (void)menuView: (BDJMenuView *)menuView didClickBtnAtIndex: (NSInteger)index;
- (void)menuView:(BDJMenuView *)menuView didClickRightBtn:(MenuType *)type;


@end
@class BDJSubMenu;
@interface BDJMenuView : UIView



//初始化方法
- (instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName;

@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, assign)MenuType type;

@property (nonatomic, weak)id<BDJMenuViewDelegate> delegate;
@end
//菜单按钮
@interface BDJMenuButton : UIControl

- (instancetype)initWithTitle:(NSString *)title;

//是否选中
@property (nonatomic, assign)BOOL clicked;
//按钮的序号
@property (nonatomic, assign)NSInteger btnIndex;

@end