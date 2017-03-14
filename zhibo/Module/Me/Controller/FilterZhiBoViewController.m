//
//  FilterZhiBoViewController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/7.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "FilterZhiBoViewController.h"
#import "GPUImage.h"
@interface FilterZhiBoViewController ()

@property (nonatomic , strong) GPUImageVideoCamera *videoCamera;

@property (nonatomic , weak) GPUImageView *captureVideoPreview;

@end

@implementation FilterZhiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addFilterCamera];
    
    [self addCloseBtn];
}

// 创建关闭按钮
- (void)addCloseBtn {
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
}

- (void)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 增加滤镜效果
- (void)addFilterCamera {
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    _captureVideoPreview = captureVideoPreview;
    
    // 设置处理链
    [_videoCamera addTarget:_captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];
}

@end
