//
//  BudejieTabBarViewController.m
//  baisibudesister
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BudejieTabBarViewController.h"
#import "BDJTabBar.h"
#import "EssenceViewController.h"
#import "BDJMenu.h"
#import "NewsViewController.h"

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
    
    //获取菜单数据
    [self loadMenuData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadMenuData {
    NSString *filePath = [self menuFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //读文件
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        BDJMenu *menu = [[BDJMenu alloc] initWithData:data error:nil];
        
        //显示
        [self showAllMenuData:menu];
    }
    
    
    //更新菜单数据
    [self downloadMenuData];
}


//显示菜单数据
- (void)showAllMenuData:(BDJMenu *)menu {
    //设置精华的菜单数据
    UINavigationController *essenceNavCtrl = [self.viewControllers firstObject];
    EssenceViewController *essenceCtrl = [essenceNavCtrl.viewControllers firstObject];
    essenceCtrl.subMenus = [[menu.menus firstObject] submenus];
    
    //设置最新的界面的菜单数据
    if (self.viewControllers.count >= 2) {
        UINavigationController *newsNavCtrl = self.viewControllers[1];
        NewsViewController *newsCtrl = [newsNavCtrl.viewControllers firstObject];
        if (menu.menus.count > 1) {
            newsCtrl.subMenus = [menu.menus[1] submenus];
        }
        
    }
   
    
}

//下载菜单数据
- (void)downloadMenuData {
    
    //http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/
    
    [BDJDownloader downloadWithURLString:@"http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/" success:^(NSData *data) {
        
        //解析
        BDJMenu *menu = [[BDJMenu alloc] initWithData:data error:nil];
        
        NSString *path = [self menuFilePath];
        
        //如果plist文件不存在，显示菜单数据
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [self showAllMenuData:menu];
        }
        
        //存到本地
        [data writeToFile:path atomically:YES];
        
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}


- (NSString *)menuFilePath {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) lastObject];
    return [docPath stringByAppendingPathComponent:@"menu.plist"];
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
