//
//  ViewController.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "ViewController.h"
#import "HHZPopupOptionsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HHZPopupOptionsView * popView = [[HHZPopupOptionsView alloc] init];
    [popView showPopupOptionsViewTitle:@[@"12223",@"sdasffsdf",@"dsafshfqwiydf"] imageArray:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
