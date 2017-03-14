//
//  MeViewController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/3.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "MeViewController.h"
#import "GBZhiBoViewController.h"
#import "FilterZhiBoViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addOpenBtn];
    
}

- (void)addOpenBtn {
    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake((GBWidth - 80) / 2, (GBHeight - 40) / 2, 80, 40)];
    [openBtn setTitle:@"开启直播" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openZhiBo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
}

- (void)openZhiBo {
    FilterZhiBoViewController *zhiboVC = [FilterZhiBoViewController new];
    [self.navigationController presentViewController:zhiboVC animated:YES completion:nil];
}


@end
