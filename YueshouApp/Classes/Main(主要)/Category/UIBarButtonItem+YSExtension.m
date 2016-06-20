//
//  UIBarButtonItem+YSExtension.m
//  YueshouApp
//
//  Created by 鄂鸿桢 on 16/6/20.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "UIBarButtonItem+YSExtension.h"

@implementation UIBarButtonItem (YSExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
