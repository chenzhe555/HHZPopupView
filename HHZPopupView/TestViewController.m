//
//  TestViewController.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/8/28.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "TestViewController.h"
#import "HHZPopupOptionsView.h"

#define RH_Common_Blue_Color  [UIColor colorWithRed:0/255.0 green:166/255.0 blue:228/255.0 alpha:1]
@interface TestViewController ()<HHZPopupOptionViewsDelegate>

@property (nonatomic, strong) HHZPopupOptionsView * popOptionsView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:NO];

}

-(void)test
{
    self.popOptionsView = [[HHZPopupOptionsView alloc] init];
    _popOptionsView.delegate = self;
    _popOptionsView.itemHeight = 66.0f;
    _popOptionsView.topShape.fillColor = RH_Common_Blue_Color;
    _popOptionsView.topShape.lineColor = RH_Common_Blue_Color;
    _popOptionsView.bgView.backgroundColor = RH_Common_Blue_Color;
    _popOptionsView.bgSelectedColor = [UIColor lightGrayColor];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.popOptionsView showPopupOptionsViewTitle:@[@"发起聊天",@"发起群聊"] imageArray:nil point:CGPointMake([UIScreen mainScreen].bounds.size.width - 26, 60)];
}

-(void)dlTapOptionAtIndex:(NSInteger)index
{
    NSLog(@"第几个:%d",index);
}

-(void)dlTapToHidden
{
    NSLog(@"hidden");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
