//
//  YSHomeViewController.m
//  YueShouApp
//
//  Created by 鄂鸿桢 on 16/6/13.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "YSHomeViewController.h"
#import "CollectionImageView.h"
#import "YSWebViewController.h"
#import <WebKit/WebKit.h>

#define ScreenSize      [UIScreen mainScreen].bounds.size

@interface YSHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) CollectionImageView *infiniteScrollView;
@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, assign) CGFloat btnY;
@property (nonatomic, assign) CGFloat scrollY;
@property (nonatomic, strong) UIScrollView *scrollView;
//定时器
@property (weak,nonatomic)NSTimer *timer;


@end

@implementation YSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"约手网";
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.panGestureRecognizer.delaysTouchesBegan = YES;
    [self.view addSubview:self.scrollView];
//    self.scrollView.scrollEnabled = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUpView];
    [self setUpTopButton];
    [self setupAdView];
    [self setUpBottomButton];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scrollY + 64);
}
#pragma mark -- 配置视图
-(void)setUpView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *images = @[@"ad1",@"ad1",@"ad1",@"ad1",@"ad1"];
    CollectionImageView *infiniteScrollView = [[CollectionImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenSize.width, 180) imageArray:images selectImageBlock:^(NSInteger index) {
        NSLog(@"点击的是第%ld个",(long)index);
    }];
    [self.scrollView addSubview:infiniteScrollView];
    self.infiniteScrollView = infiniteScrollView;
}

#pragma mark -- 配置上部按钮
- (void)setUpTopButton
{
    
    NSArray *images = @[@"1_24",@"2_24",@"3_24",@"4_24",@"5_24",@"6_24",@"7_24",@"8_24"];
    NSArray *titles = @[@"众筹",@"征信查询",@"卡片微金融",@"便捷金融",@"科学院",@"保险服务",@"理财",@"商城"];
    //中间的按钮
    int maxCols = 4;
    CGFloat margin = 1;
    CGFloat buttonW = (self.view.bounds.size.width - 3) / maxCols;
    CGFloat buttonH = buttonW;
    CGFloat buttonStartX = 0;
    CGFloat buttinStartY = CGRectGetMaxY(self.infiniteScrollView.frame) + margin;
    
    for (int i = 0; i < images.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        
        button.backgroundColor = [UIColor whiteColor];
        //设置内容
        button.tag = i;
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        //设置frame
        CGFloat btnX;
        if (i < maxCols) {
            btnX = buttonStartX + (i * (buttonW + margin));
        } else {
            int j = i - maxCols;
            btnX = buttonStartX + (j * (buttonW + margin));
            self.btnY = buttinStartY + (((int)(i / maxCols) + 1) * (buttonH + margin));
        }
        CGFloat btnY = buttinStartY + ((int)(i / maxCols) * (buttonH + margin));
        button.frame = CGRectMake(btnX, btnY, buttonW, buttonH);
        
        [self initButton:button];
        
        [self.scrollView addSubview:button];
    }
}

#pragma mark - 配置广告轮播图
- (void)setupAdView
{
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, self.btnY + 20, ScreenSize.width, 40)];
    adView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:adView];
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    [adLabel setFont:[UIFont systemFontOfSize:12]];
    adLabel.text = @"优质商家";
    [adView addSubview:adLabel];
    UIButton *adButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width - 100, 10, 90, 20)];
    [adButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [adButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [adButton setTitle:@"查看所有商家" forState:UIControlStateNormal];
    [adView addSubview:adButton];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *images = @[@"a1",@"a2",@"a3",@"a1",@"a2",@"a3"];
    UIScrollView *adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(adView.frame) + 1, ScreenSize.width, 69)];
//    adScrollView.pagingEnabled = YES;
    adScrollView.backgroundColor = [UIColor whiteColor];
    adScrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:adScrollView];
    for (int i = 0; i < images.count; i++) {
        UIButton *imageBtn = [[UIButton alloc] init];
        imageBtn.tag = 200 + i;
        [imageBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", images[i]]] forState:UIControlStateNormal];
        imageBtn.frame = CGRectMake(2 + 122 * i, 2, 120, 65);
        [adScrollView addSubview:imageBtn];
    }
    UIButton *tempBtn = [adScrollView viewWithTag:200];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(2 + 122 * 6, 0, 120, 65)];
    button.backgroundColor = tempBtn.backgroundColor;
    [button.imageView setImage:tempBtn.imageView.image];
    
    [adScrollView addSubview:button];
    adScrollView.contentSize = CGSizeMake(120 * (images.count - 1), 0);
    self.adScrollView = adScrollView;
    adScrollView.tag = 100;
    //启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
    //为滚动视图指定代理
    adScrollView.delegate = self;
}

#pragma mark -- 滚动视图的代理方法
//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"正在拖拽视图，所以需要将自动播放暂停掉");
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [self.timer setFireDate:[NSDate distantFuture]];
}

//视图静止时（没有人在拖拽），开启定时器，让自动轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //视图静止之后，过1.5秒在开启定时器
    //[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]  返回值为从现在时刻开始 再过1.5秒的时刻。
    NSLog(@"开启定时器");
    [self.timer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}


//定时器的回调方法   切换界面
- (void)changeView{
    //得到scrollView
    UIScrollView *scrollView = [self.view viewWithTag:100];
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_X = scrollView.contentOffset.x;
    //每次切换一个屏幕
    offset_X += 120;
    
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_X > 90 * 5) {
        scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_X > 90 * 5) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }else{
        [scrollView setContentOffset:resultPoint animated:YES];
    }
    
}

#pragma mark - 配置下部部按钮
- (void)setUpBottomButton
{
    NSArray *images = @[@"9_24",@"10_24",@"11_24",@"12_24",@"13_24",@"14_24",@"15_24",@"16_24"];
    NSArray *titles = @[@"母婴亲子",@"医疗健康",@"我要结婚",@"都市丽人",@"爱车学车",@"酒店旅游",@"生活服务",@"休闲娱乐"];
    //中间的按钮
    int maxCols = 4;
    CGFloat margin = 1;
    CGFloat buttonW = (self.view.bounds.size.width - 3) / maxCols;
    CGFloat buttonH = buttonW;
    CGFloat buttonStartX = 0;
    CGFloat buttinStartY = CGRectGetMaxY(self.adScrollView.frame) + margin + 20;
    
    for (int i = 0; i < images.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = i + 8;
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        //设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        //设置frame
        CGFloat btnX;
        if (i < maxCols) {
            btnX = buttonStartX + (i * (buttonW + margin));
        } else {
            int j = i - maxCols;
            btnX = buttonStartX + (j * (buttonW + margin));
            self.scrollY = buttinStartY + ((int)((i / maxCols) + 1) * (buttonH + margin));

        }
        CGFloat btnY = buttinStartY + ((int)(i / maxCols) * (buttonH + margin));
        button.frame = CGRectMake(btnX, btnY, buttonW, buttonH);
        
        [self initButton:button];
        
        [self.scrollView addSubview:button];
    }
}

- (void)buttonOnClick:(UIButton *)button
{
    if (button.tag == 0) {
        [self loadWithView:@"http://yueshouwang.com/wap"];
    } else if (button.tag == 7) {
        [self loadWithView:@"http://abc.yueshouwang.com/mobile"];
    }
}

#pragma mark - 私有方法
- (void)initButton:(UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, -30.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}

- (void)loadWithView:(NSString *)string
{
//    UIViewController *webVc = [[UIViewController alloc] init];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    YSWebViewController *webVc = [[YSWebViewController alloc] init];
//    webVc.webView.frame = CGRectMake(0, 0, width, height);
    webVc.hidesBottomBarWhenPushed = YES;
//    webView.navigationDelegate = webVc;
//    webView.UIDelegate = webVc;
    webView.delegate = webVc;
    // 2.创建URL
    NSURL *url = [NSURL URLWithString:string];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    webVc.view.backgroundColor = [UIColor redColor];
    [webView loadRequest:request];
    [webVc.view addSubview:webView];
//    webView.navigationDelegate
    [self pushNextVC:webVc];
    
}

-(void)pushNextVC:(UIViewController *)vc{
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
