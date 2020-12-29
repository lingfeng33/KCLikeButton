//
//  KCViewController.m
//  KCLikeButton
//
//  Created by lingfeng33 on 12/29/2020.
//  Copyright (c) 2020 lingfeng33. All rights reserved.
//

#import "KCViewController.h"
#import <KCLikeButton.h>

@interface KCViewController ()

@end

@implementation KCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat cx     = 5; //倍数
    CGFloat width  = 50 * cx;
    CGFloat height = 45 * cx;
    KCLikeButton * likeView = [[KCLikeButton alloc] initWithFrame:CGRectMake(10, 20, width, height)];
   
    likeView.likeDuration = 0.5;
    likeView.zanFillColor = [UIColor redColor];
    [self.view addSubview:likeView];
    self.view.backgroundColor = [UIColor blackColor];
    
    [likeView setLikeBeforBlock:^{
        NSLog(@"----------");
    }];
    
    [likeView setAftterBeforBlock:^{
       
        NSLog(@"+++++++++++");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
