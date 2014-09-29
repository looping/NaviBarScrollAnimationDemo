//
//  ViewController.m
//  NaviBarScrollAnimationDemo
//
//  Created by Looping on 14/9/24.
//  Copyright (c) 2014年 RidgeCorn. All rights reserved.
//

#import "ViewController.h"
#import "ScrollAnimationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    [self setTitle:@"Demonstration"];
    
    [self.view addSubview:({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [button setTitle:@"PUSH" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button setCenter:self.view.center];
        button;
    })];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:nil];
}

- (void)pushViewController {
    [self.navigationController pushViewController:[ScrollAnimationViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
