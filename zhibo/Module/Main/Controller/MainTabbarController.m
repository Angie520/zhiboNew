//
//  MainTabbarController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/3.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 通过runTime创建tabbar的子控制器。。
    [self creatBarButtonClassArray:@[@"HomeViewController",@"CollectedViewController",@"FindViewController",@"MeViewController"] titleArray:@[@"首页",@"关注",@"发现",@"我"] imageArray:nil selectdImageArray:nil];
    
}


// 通过runTime创建tabbar的子控制器。。
- (void)creatBarButtonClassArray:(NSArray <NSString *> *)classArray titleArray:(NSArray <NSString *> *) titleArray imageArray:(NSArray <UIImage *>*)imageArray selectdImageArray:(NSArray <UIImage *>*)selectdImageArray{
    
    // imageWithRenderingMode 图片的渲染模式  UIImageRenderingModeAlwaysOriginal 保持原始.
    // 防止tabbar图片被渲染成蓝色。
//     UIImage * image = [UIImage imageNamed:imageName];
//     image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableArray *vcArray = @[].mutableCopy;
    //判断是类型数组比较短还是标题，正常情况是一样长的，这里防止不小心哪里短了，导致crash
    NSUInteger shortArrayCount = classArray.count < titleArray.count ? classArray.count:titleArray.count;
    
    for (int i = 0; i < shortArrayCount; i++) {
        Class VCClass = NSClassFromString(classArray[i]);
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:imageArray[i]?:nil selectedImage:selectdImageArray[i]?:nil];
        
        // 需要修改系统的tabbar字体颜色。
//        NSMutableDictionary *dictAttr = [NSMutableDictionary dictionary];
//        [dictAttr setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//        [item setTitleTextAttributes:dictAttr forState:UIControlStateSelected];
        
        
        // 创建控制器。
        UIViewController *vc = [VCClass new];
        // 设置标题
        vc.title = titleArray[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [nav setTabBarItem:item];
        [vcArray addObject:nav];
    }
    self.viewControllers = vcArray;
    
}

@end
