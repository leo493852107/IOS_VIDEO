//
//  CZMoviePlayerViewController.h
//  B05-视频播放
//
//  Created by leo on 15/8/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZMoviePlayerViewController;
@protocol CZMoviePlayerViewControllerDelegate <NSObject>

- (void)moviePlayerViewController:(CZMoviePlayerViewController *)vc didFinishCapturedImage:(UIImage *)image;

@end

@interface CZMoviePlayerViewController : UIViewController

@property (nonatomic, strong) NSURL *movieURL;

//设置截图时间
@property (nonatomic, strong) NSArray *captureTimes;

@property (nonatomic, weak) id<CZMoviePlayerViewControllerDelegate> delegate;

@end
