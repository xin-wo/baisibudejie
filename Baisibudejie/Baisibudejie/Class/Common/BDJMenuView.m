//
//  BDJMenuView.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BDJMenuView.h"
#import "BDJMenu.h"

#define kContainerViewTag (100)

@interface BDJMenuView()
//滚动视图
@property (nonatomic, strong)UIScrollView *scrollView;
//下划线
@property (nonatomic, strong)UIView *lineView;

@end

@implementation BDJMenuView

- (instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName {
    if (self = [super init]) {
        //1.左边的滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //约束
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 60));
            
            
        }];
        
        
        //循环创建按钮
        //容器视图
        UIView *containerView = [[UIView alloc] init];
        containerView.tag = kContainerViewTag;
        [scrollView addSubview:containerView];
        scrollView.showsHorizontalScrollIndicator = NO;
        //约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        
        //按钮的宽度
        CGFloat btnW = 60;
        //上一次添加的子视图
        UIView *lastView = nil;
        //按钮的序号
        NSInteger i = 0;
        
        for (BDJSubMenu *subMenu in array) {
            BDJMenuButton *btn = [[BDJMenuButton alloc]initWithTitle:subMenu.name];
            [containerView addSubview:btn];
            
            btn.btnIndex = i;
            if (i == 0) {
                btn.clicked = YES;
            }
            
            //约束
            [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.width.mas_equalTo(btnW);
                
                if (lastView == nil) {
                    make.left.equalTo(containerView);
                    
                } else {
                    make.left.equalTo(lastView.mas_right);
                }
               
                
            }];
            lastView = btn;
            
            i++;
        }
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView);
        }];
        
        
        
        //2.右边的按钮
        UIButton *rightBtn = [UIButton createBtnTitle:nil bgImageName:iconName highlightBgImageName:selectIconName target:self action:@selector(clickRight)];
        [self addSubview:rightBtn];
        
        //约束
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(36);
            
            
        }];
        
        //下划线
        self.lineView = [[UIView alloc] init];
        [self.scrollView addSubview:self.lineView];
        self.lineView.backgroundColor = [UIColor redColor];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView);
            make.bottom.equalTo(self.scrollView).offset(-4);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(2);
        }];
        
       
    }
    
    return  self;
}
//点击右边按钮
- (void)clickRight {
    
}
//切换按钮的选中状态
- (void)setSelectIndex:(NSInteger)selectIndex {
    if (_selectIndex != selectIndex){
       
        //取消之前选中的按钮
        BDJMenuButton *lastBtn = nil;
        BDJMenuButton *curBtn = nil;
        
        UIView *containerView = [self.scrollView viewWithTag:kContainerViewTag];
        for (BDJMenuButton *tmpBtn in containerView.subviews) {
            if (tmpBtn.btnIndex == selectIndex) {
                curBtn = tmpBtn;
            } else if (tmpBtn.btnIndex == _selectIndex){
                lastBtn = tmpBtn;
            }
            
        }
        lastBtn.clicked = NO;
        
        
        //选中当前的按钮
        _selectIndex = selectIndex;
        curBtn.clicked = YES;
        
        //修改下划线的位置
       [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(curBtn);
           make.bottom.equalTo(self.scrollView).offset(-4);
           make.width.mas_equalTo(60);
           make.height.mas_equalTo(2);
       }];
        
        //将当前选中的按钮尽可能显示在中间
        CGFloat x = CGRectGetMidX(curBtn.frame) - self.scrollView.bounds.size.width/2;
        
        //左边不能越界
        if (x<0) {
            x=0;
        }
        
        //右边不能越界
        if (x > self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
            x  = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        self.scrollView.contentOffset = CGPointMake(x, 0);
        
    }
   
    
    
}


//点击菜单按钮
- (void)clickMenu:(BDJMenuButton *)btn {
    //切换按钮的选中状态
    self.selectIndex = btn.btnIndex;
 
    //切换界面
    [self.delegate menuView:self didClickBtnAtIndex:self.selectIndex];
    
}

@end

@implementation BDJMenuButton {
    //文字
    UILabel *_titleLabel;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
     
        _titleLabel = [UILabel createLabel:title textColor:[UIColor grayColor] font:[UIFont systemFontOfSize: 20]];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        //约束
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

//切换选中状态
- (void)setClicked:(BOOL)clicked {
    _clicked = clicked;
    if (_clicked) {
        _titleLabel.textColor = [UIColor redColor];
        
    } else {
        _titleLabel.textColor = [UIColor grayColor];
    }
    
}


@end

