//
//  ViewController.m
//  Animation
//
//  Created by Li Nan on 16/12/2.
//  Copyright © 2016年 nancy. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"


#define  pi 3.14159265359
#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface ViewController(){
    LoadingView *loadingView;
    UILabel *loadingLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:loadingView];
    
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    loadingLabel.text = @"Loading...";
    loadingLabel.font = [UIFont systemFontOfSize:16];
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.center = self.view.center;
    
    [self.view addSubview:loadingLabel];
    //[self performSelector:@selector(dismissLoadingView) withObject:self afterDelay:3.0];
}

- (void)dismissLoadingView{
    [UIView animateWithDuration:1.0 animations:^{
        loadingView.alpha = 0;
        loadingLabel.alpha = 0;
        [loadingView dismissAnimation];
    }
    completion:^(BOOL finished){
        [loadingView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
