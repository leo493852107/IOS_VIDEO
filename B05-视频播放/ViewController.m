//
//  ViewController.m
//  B05-视频播放
//
//  Created by leo on 15/8/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CZMoviePlayerViewController.h"

@interface ViewController () <CZMoviePlayerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //播放视频
    CZMoviePlayerViewController *movieVC = [[CZMoviePlayerViewController alloc]init];
    
    //设置视频URL
    //获取视频路径 http://www.youku.com/xxx.mp4
    movieVC.movieURL = [[NSBundle mainBundle] URLForResource:@"promo_full.mp4" withExtension:nil];
    
    //设置截图时间
    movieVC.captureTimes = @[@(2.0),@(10.0)];
    
    //设置代理
    movieVC.delegate = self;
    
    [self presentViewController:movieVC animated:YES completion:nil];
}

#pragma mark 视频播放器的代理
-(void)moviePlayerViewController:(CZMoviePlayerViewController *)vc didFinishCapturedImage:(UIImage *)image{
    
    //显示截图
    self.imgView.image = image;
}



@end
