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
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    HHZPopupOptionsView * popView = [[HHZPopupOptionsView alloc] init];
    [popView configSelectedBackgroundColor:[UIColor lightGrayColor]];
//    [popView configBGViewBackgorundColor:[UIColor colorWithRed:0/255.0 green:142/255.0 blue:242/255.0 alpha:1]];
    [popView configTitleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:18.0]];
    
//    [popView showPopupOptionsViewTitle:@[@"12223",@"你说什么呢？",@"dsafshfqwiydf",@"ashbv1213针",@"xzxbu22e79!@$%%"] imageArray:@[[UIImage imageNamed:@"select1"],[UIImage imageNamed:@"select2"],[UIImage imageNamed:@"select3"],[UIImage imageNamed:@"select4"],[UIImage imageNamed:@"select5"]]];
    
    
//     [popView showPopupOptionsViewTitle:@[@"12223",@"你说什么呢？",@"dsafshfqwiydf",@"ashbv1213针",@"xzxbu22e79!@$%%"] imageArray:nil rect:CGRectMake(50, 50, 0, 0)];

//    [popView showPopupOptionsViewTitle:@[@"12223",@"你说什么呢？",@"dsafshfqwiydf",@"ashbv1213针",@"xzxbu22e79!@$%%"] imageArray:nil shapeLocation:HHZPopupOptionsViewTopShapeLocationRight rect:CGRectMake(100,50,0,0)];
//    [popView showPopupOptionsViewTitle:@[@"12223",@"你说什么呢？",@"dsafshfqwiydf",@"ashbv1213针",@"xzxbu22e79!@$%%"] imageArray:nil rect:CGRectMake(100,50,0,0)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    HHZPopupOptionsView * popView = [[HHZPopupOptionsView alloc] init];
    [popView configSelectedBackgroundColor:[UIColor lightGrayColor]];
    [popView configTitleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:18.0]];
    [popView showPopupOptionsViewTitle:@[@"12223",@"你说什么呢？",@"dsafshfqwiydf",@"ashbv1213针",@"xzxbu22e79!@$%%"] imageArray:nil shapeLocation:HHZPopupOptionsViewTopShapeLocationAutomatic point:point];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
