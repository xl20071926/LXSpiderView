//
//  ViewController.m
//  LXSpiderView
//
//  Created by Leexin on 16/8/13.
//  Copyright © 2016年 Garden.Lee. All rights reserved.
//

#import "ViewController.h"
#import "LXSpiderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LXSpiderView *spiderView = [[LXSpiderView alloc] initWithFrame:CGRectMake(100.f, 100.f, 200.f, 200.f) radius:80.f];
    spiderView.valueArray = @[@(0.5), @(0.6), @(0.4), @(0.8), @(0.9)];
    spiderView.titleArray = @[@"力量", @"智力", @"敏捷", @"体质", @"耐力"];
    [self.view addSubview:spiderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
