//
//  GBPlayingViewController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/6.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "GBPlayingViewController.h"
#import <IJKMediaFramework/IJKMediaPlayer.h>

@interface GBPlayingViewController ()

@property (nonatomic , strong) IJKFFMoviePlayerController *player;

@end

@implementation GBPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addPlayAndToPlaying];
    
}

// 不释放会内存溢出
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
}

// 创建播放器和播放
- (void)addPlayAndToPlaying {
    // 拉流地址
    NSURL *url = [NSURL URLWithString:self.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，防止被销毁
    _player = playerVc;
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:playerVc.view atIndex:1];
    
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [playerVc.view addSubview:closeBtn];
    
    
}

- (void)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
