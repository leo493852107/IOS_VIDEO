//
//  CZMoviePlayerViewController.m
//  B05-视频播放
//
//  Created by leo on 15/8/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CZMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CZMoviePlayerViewController ()

@property (strong, nonatomic)MPMoviePlayerController *movieController;

@end

@implementation CZMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //断言
    NSAssert(self.movieURL != nil, @"请先设置movieURL");
    
    //初始化一个视频播放器
    MPMoviePlayerController *movieController = [[MPMoviePlayerController alloc]initWithContentURL:self.movieURL];
    
    //设置movieControl的view的尺寸
    movieController.view.frame = self.view.bounds;
    
    //设置视频播放的适配
    movieController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //把movieControl添加到当前视频控制器的view
    [self.view addSubview:movieController.view];
    
    //播放
    [movieController prepareToPlay];
    
    [movieController play];
    
    //赋值
    self.movieController = movieController;
    
    //监听Done事件 通过通知的方式实现
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //监听视频播放完成
    [center addObserver:self selector:@selector(exit) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //截屏 设置时间
//    [self.movieController requestThumbnailImagesAtTimes:@[@(2.0)] timeOption:MPMovieTimeOptionNearestKeyFrame];
    if (self.captureTimes) {
        [self.movieController requestThumbnailImagesAtTimes:self.captureTimes timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
    //监听截屏返回图片
    [center addObserver:self selector:@selector(captureImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
}

#pragma mark 获取截图
- (void)captureImage:(NSNotification *)noti{
    NSLog(@"%@",noti.userInfo);
    
    
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(moviePlayerViewController:didFinishCapturedImage:)]) {
        
        UIImage *img = noti.userInfo[MPMoviePlayerThumbnailImageKey];
        
        [self.delegate moviePlayerViewController:self didFinishCapturedImage:img];
    }
    
}



#pragma mark 退出
- (void)exit{
    NSLog(@"%s",__func__);
    //退出当前的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
