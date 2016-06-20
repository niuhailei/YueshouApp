//
//  YSNavigationController.m
//  YueshouApp
//
//  Created by 鄂鸿桢 on 16/6/20.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "YSNavigationController.h"

@interface YSNavigationController ()

@end

@implementation YSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //清空弹出手势的代理,可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = nil;
    
    
}

+(void)initialize
{
    [[UINavigationBar appearance] setTintColor:[UIColor blueColor]];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highlightedImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
//        //        viewController.navigationItem.leftBarButtonItem = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highlightedImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
//    }
//    
//    [super pushViewController:viewController animated:YES];
//}
//
//- (void)back
//{
//    [self popViewControllerAnimated:YES];
//}
//
//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}


@end
