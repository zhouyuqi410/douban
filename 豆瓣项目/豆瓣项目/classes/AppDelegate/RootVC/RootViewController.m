//
//  RootViewController.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "RootViewController.h"

#import "ActivityListViewController.h"
#import "CinemaListViewController.h"
#import "MovieListViewController.h"
#import "UserViewController.h"
#import "DB_COLOR.h"
#import "UIImage+ImageByColor.h"
#import "CustomTabbar.h"

@interface RootViewController ()

@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建四个根视图控制器
    [self createChildViewController];
    
    //设置tabBarItem文本标题颜色
    [self setTabBarItemTextAttributes];
    
    [self setCustomTabBar];
}



-(void)setCustomTabBar {
    [self setValue:[[CustomTabbar alloc]init] forKey:@"tabBar"];
}


- (void)setTabBarItemTextAttributes {
    NSMutableDictionary *normalAtt = [NSMutableDictionary dictionary];
    normalAtt[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置选中后文本颜色
    NSMutableDictionary *selectorAttr = [NSMutableDictionary dictionary];
    [selectorAttr setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    //配置文本颜色
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAtt forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectorAttr forState:UIControlStateSelected];
    
    //设置tabBar的背景图 根据颜色
    //color -> image
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imagewithColor:DB_MAIN_COLOR]];
    
}



- (void)createChildViewController {
    [self addOneChildViewController:[[ActivityListViewController alloc] initWithStyle:UITableViewStylePlain] titile:@"活动" normalImage:@"paper" selectorImage:@"paperH"];
    [self addOneChildViewController:[[MovieListViewController alloc] initWithStyle:UITableViewStylePlain] titile:@"电影" normalImage:@"video" selectorImage:@"videoH"];
    [self addOneChildViewController:[[CinemaListViewController alloc] initWithStyle:UITableViewStylePlain] titile:@"影院" normalImage:@"2image" selectorImage:@"2imageH"];
    [self addOneChildViewController:[[UserViewController alloc] init] titile:@"个人中心" normalImage:@"person" selectorImage:@"personH"];
}

- (void)addOneChildViewController:(UIViewController *)viewController titile:(NSString *)title normalImage:(NSString *)normalImage selectorImage:(NSString *)selectorImage {
    viewController.title = title;
    viewController.view.backgroundColor = DB_RANDOM_COLOR;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];;
    UIImage *image = [UIImage imageNamed:selectorImage];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
    
   
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
