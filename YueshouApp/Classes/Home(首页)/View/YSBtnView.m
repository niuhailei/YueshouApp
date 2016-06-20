//
//  YSBtnView.m
//  YueshouApp
//
//  Created by 鄂鸿桢 on 16/6/20.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "YSBtnView.h"

@implementation YSBtnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
//        UIImage *image = [UIImage image
//        backgroundView.image = [UIImage
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 1"]];
        [self setupBtnWithIcon:@"1_sys" title:@"转发"];
        [self setupBtnWithIcon:@"2_sq" title:@"评论"];
        [self setupBtnWithIcon:@"3_cz" title:@"赞"];
    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    btn.backgroundColor = YSRandomColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
//    label.backgroundColor = YSRandomColor;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:label];
    [self addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = (int)self.subviews.count;
    CGFloat margin = 40;
    CGFloat btnW = (self.width - 6 * margin) / 3;
    CGFloat btnY = margin;
    CGFloat btnH = btnW;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        UILabel *label = btn.subviews[0];
        label.width = btnW;
        label.height = 30;
        label.x = 0;
        CGFloat labelY = btnH;
        label.y = labelY;
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnY;
        btn.x = margin + (i * (btnW + margin * 2)) ;
    }
}

#pragma mark - 私有方法
- (void)initButton:(UIButton *)btn {
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(-50.0, -50.0, -50.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}

@end
