//
//  BudejieTabBarViewController.m
//  baisibudesister
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BudejieTabBarViewController.h"
#import "BDJTabBar.h"

@interface BudejieTabBarViewController ()

@end

@implementation BudejieTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tabBar.tintColor = [UIColor colorWithWhite:64.0f alpha:1.0f];
    [UITabBar appearance].tintColor = [UIColor colorWithWhite:64.0f/255 alpha:1.0f];
    //创建视图控制器
    [self createViewControllers];
    
    //使用自定制的TabBar
    [self setValue:[[BDJTabBar alloc] init] forKey:@"tabBar"];
    
}
//创建视图控制器
- (void)createViewControllers {
    //精华
    [self addSubController:@"EssenceViewController" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon" title:@"精华"];
    //最新
    [self addSubController:@"NewsViewController" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon" title:@"最新"];
    //添加
   
    
    //关注
    [self addSubController:@"AttentionViewController" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    //我的
    [self addSubController:@"ProfileViewController" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon" title:@"我的"];
    
}

//添加单个视图控制器
- (void)addSubController: (NSString *)ctrlName imageName: (NSString *)imageName selectImageName: (NSString *)selectImageName title: (NSString *)title {
    Class cls = NSClassFromString(ctrlName);
    UIViewController *tmpCtrl = [[cls alloc] init];
    //设置文字
    tmpCtrl.tabBarItem.title = title;
    //图片
    tmpCtrl.tabBarItem.image = [UIImage imageNamed:imageName];
    tmpCtrl.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    //导航
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:tmpCtrl];
    //让tabbarCtrl管理这个视图控制器
    [self addChildViewController:navCtrl];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
