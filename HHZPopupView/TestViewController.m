//
//  TestViewController.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/8/28.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "TestViewController.h"
#import "HHZPopupOptionsView.h"
#import "HHZDropDownMenu.h"
#import "HHZDropDownMenuNormalCell.h"

#define RH_Common_Blue_Color  [UIColor colorWithRed:0/255.0 green:166/255.0 blue:228/255.0 alpha:1]
@interface TestViewController ()<HHZPopupOptionViewsDelegate,HHZDropDownMenuDelegate,HHZDropDownMenuDataSource>

@property (nonatomic, strong) HHZPopupOptionsView * popOptionsView;
@property (nonatomic, strong) HHZDropDownMenu * dropDownMenu;

@property (nonatomic, strong) NSArray * arr1;
@property (nonatomic, strong) NSArray * arr2;
@property (nonatomic, strong) NSArray * arr3;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    

    [self createDropDownMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createPopUpView
{
    self.popOptionsView = [[HHZPopupOptionsView alloc] init];
    _popOptionsView.delegate = self;
    _popOptionsView.itemHeight = 66.0f;
    _popOptionsView.itemWidth = 220.0f;
    _popOptionsView.topShape.fillColor = RH_Common_Blue_Color;
    _popOptionsView.topShape.lineColor = RH_Common_Blue_Color;
    _popOptionsView.bgView.backgroundColor = RH_Common_Blue_Color;
    _popOptionsView.bgSelectedColor = [UIColor lightGrayColor];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.popOptionsView showPopupOptionsViewTitle:@[@"发起聊天",@"发起群聊"] imageArray:nil point:CGPointMake([UIScreen mainScreen].bounds.size.width - 26, 60)];
}

#pragma mark HHZDropDownMenu
-(void)createDropDownMenu
{
    self.arr1 = @[@[@"1",@"2",@"3"]];
    self.arr2 = @[@[@"21",@"22"],@[@"23",@"22",@"23"]];
    self.arr3 = @[@[@"31",@"323",@"33",@"32",@"33",@"31",@"32"]];
    
    self.dropDownMenu = [[HHZDropDownMenu alloc] initWithPoint:CGPointMake(0, 64)];
    self.dropDownMenu.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44);
    self.dropDownMenu.delegate = self;
    self.dropDownMenu.dataSource = self;
    [self.view addSubview:self.dropDownMenu];
    
    
}

-(NSArray<HHZDropDownMenuItemModel *> *)dlTopMenus
{
    return @[[HHZDropDownMenuItemModel generateWithTitle:@"创建时间" isShowMore:NO],[HHZDropDownMenuItemModel generateWithTitle:@"审批状态" isShowMore:YES]];
}

-(NSInteger)numberOfSectionsInMenu:(HHZDropDownMenu *)menu
{
    if (menu.currentIndex == 0)
    {
        return self.arr1.count;
    }
    else if (menu.currentIndex == 1)
    {
        return self.arr2.count;
    }
    else if (menu.currentIndex == 2)
    {
        return self.arr3.count;
    }
    else
    {
        return 1;
    }
}

-(NSInteger)menu:(HHZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section
{
    if (menu.currentIndex == 0)
    {
        return ((NSArray *)self.arr1[section]).count;
    }
    else if (menu.currentIndex == 1)
    {
        return ((NSArray *)self.arr2[section]).count;
    }
    else if (menu.currentIndex == 2)
    {
        return ((NSArray *)self.arr3[section]).count;
    }
    else
    {
        return 0;
    }
}

-(NSString *)menu:(HHZDropDownMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (menu.currentIndex == 0)
    {
        return ((NSArray *)self.arr1[indexPath.section])[indexPath.row];
    }
    else if (menu.currentIndex == 1)
    {
        return ((NSArray *)self.arr2[indexPath.section])[indexPath.row];
    }
    else if (menu.currentIndex == 2)
    {
        return ((NSArray *)self.arr3[indexPath.section])[indexPath.row];
    }
    else
    {
        return @"";
    }
}

-(UITableViewCell *)menu:(HHZDropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arr;
    if (menu.currentIndex == 0)
    {
        arr = self.arr1;
    }
    else if (menu.currentIndex == 1)
    {
        arr = self.arr2;
    }
    else if (menu.currentIndex == 2)
    {
        arr = self.arr3;
    }
    return [HHZDropDownMenuNormalCell configCellWithTableView:menu.tableView indexPath:indexPath dataArray:arr];
}

-(void)dlTapTopMenuItemAtIndex:(NSInteger)index isSelected:(BOOL)isSelected
{
    NSLog(@"index:%ld\nselected:%d",(long)index,isSelected);
}

@end
