//
//  BDJMenuViewController.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BDJMenuViewController.h"
#import "BDJTableViewController.h"
#import "BDJMenu.h"

@interface BDJMenuViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

//视图控制器的数组
@property (nonatomic, strong)NSMutableArray *ctrlArray;

//分页视图控制器
@property (nonatomic, strong)UIPageViewController *pageCtrl;


@end

@implementation BDJMenuViewController

/**懒加载初始化*/
- (NSMutableArray *)ctrlArray {
    if (nil == _ctrlArray) {
        _ctrlArray = [NSMutableArray array];
    }
    return _ctrlArray;
}


- (void)setSubMenus:(NSArray *)subMenus {
    
    _subMenus = subMenus;
    
    //循环创建视图控制器
    for (BDJSubMenu *subMenu in subMenus) {
        
        BDJTableViewController *ctrl = [[BDJTableViewController alloc] init];
        ctrl.url = subMenu.url;
        
        ctrl.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f];
        
        [self.ctrlArray addObject:ctrl];
    }
    
    //创建分页控制器
    [self createPageCtrl];
    
}


//创建分页控制器
- (void)createPageCtrl {
    
    UIPageViewController *pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //设置代理
    pageCtrl.delegate = self;
    pageCtrl.dataSource = self;
    
    // @[@"1",@"3",@"2"];
    [pageCtrl setViewControllers:@[[self.ctrlArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:pageCtrl.view];
    
    self.pageCtrl = pageCtrl;
    
    //约束
    [pageCtrl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController代理
//返回向后滑动时显示的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    //1.当前的序号
    NSInteger curIndex = [self.ctrlArray indexOfObject:viewController];
    
    //2.获取后面的视图控制器
    if (curIndex + 1 >= self.ctrlArray.count) {
        return nil;
    }else{
        return self.ctrlArray[curIndex+1];
    }
    
}

//返回向前滑动时显示的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    //1.获取当前的序号
    NSInteger curIndex = [self.ctrlArray indexOfObject:viewController];
    
    //2.获取前面的视图控制器
    if (curIndex - 1 < 0) {
        return nil;
    }else{
        return self.ctrlArray[curIndex-1];
    }
    
}


@end
