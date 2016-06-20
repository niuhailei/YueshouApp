//
//  YSTabBarController.m
//  YueshouApp
//
//  Created by 鄂鸿桢 on 16/6/20.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "YSTabBarController.h"
#import "YSHomeViewController.h"
#import "YSCrowdfundingViewController.h"
#import "YSServeViewController.h"
#import "YSProfileViewController.h"

@interface YSTabBarController ()< UITabBarControllerDelegate>
@property (nonatomic, weak) YSHomeViewController *home;
@property (nonatomic, weak) YSCrowdfundingViewController *crowdfunding;
@property (nonatomic, weak) YSServeViewController *serve;
@property (nonatomic, weak) YSProfileViewController *profile;
@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;

@end

@implementation YSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //添加子控制器
    [self addAllChildVcs];
    
}


- (void)addAllChildVcs
{
    YSHomeViewController *home = [[YSHomeViewController alloc] init];
    [self addOneChildVc:home title:@"首页" imageName:@"17_24" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    YSCrowdfundingViewController *crowdfunding = [[YSCrowdfundingViewController alloc] init];
    [self addOneChildVc:crowdfunding title:@"众筹" imageName:@"5_zc" selectedImageName:@"tabbar_message_center_selected"];
    self.crowdfunding = crowdfunding;
    
    YSServeViewController *serve = [[YSServeViewController alloc] init];
    [self addOneChildVc:serve title:@"服务" imageName:@"6_fw" selectedImageName:@"tabbar_discover_selected"];
    self.serve = serve;
    
    YSProfileViewController *profile = [[YSProfileViewController alloc] init];
    [self addOneChildVc:profile title:@"我" imageName:@"20_24" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}

+(void)initialize
{
    [[UITabBar appearance] setTintColor:[UIColor blueColor]];
}


- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //    childVc.view.backgroundColor = SWRandomColor;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    YSNavigationController *navVc = [[YSNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navVc];
}




@end
