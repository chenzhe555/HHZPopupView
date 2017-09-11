//
//  HHZDropDownMenu.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZDropDownMenu.h"
#import "HHZDropDownMenuCell.h"
#import <HHZUtils/HHZKitTool.h>

@interface HHZDropDownMenu ()<HHZDropDownMenuItemDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * menusArray;
@property (nonatomic, strong) HHZDropDownMenuItem * currentItem;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation HHZDropDownMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _type = HHZDropDownMenuTypeNormal;
        _currentIndex = 0;
    }
    return self;
}

-(void)setDataSource:(id<HHZDropDownMenuDataSource>)dataSource
{
    _dataSource = dataSource;
    if (_dataSource)
    {
        [self createTopMenusView];
        [self createTableView];
    }
}

//创建顶部视图
-(void)createTopMenusView
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(dlTopMenus)])
    {
        self.menusArray = [_dataSource dlTopMenus];
    }
    if (self.menusArray.count == 0) return;
    
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / self.menusArray.count;
    
    for (int i = 0; i < self.menusArray.count; ++i)
    {
        HHZDropDownMenuItem * item = [[HHZDropDownMenuItem alloc] init];
        item.frame = CGRectMake(i*itemWidth, 0, itemWidth, self.bounds.size.height);
        [item configItemTitle:self.menusArray[i] index:i delegate:self];
        item.tag = 666 + i;
        [self addSubview:item];
    }
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIWindow * window = [HHZKitTool getMainWindow];
    self.tableView.frame = CGRectMake(0, 64 + 44, window.bounds.size.width, window.bounds.size.height - 64 - 44);
    
    self.tableView.hidden = YES;
}

#pragma mark HHZDropDownMenuItemDelegate
-(void)dlTapItemAtIndex:(NSInteger)index
{
    _currentIndex = index;
    [self addTableViewOnWindow];
    HHZDropDownMenuItem * item = [self viewWithTag:(666 + index)];
    if (item == _currentItem)
    {
        _currentItem.isSelected = !_currentItem.isSelected;
        if (!_currentItem.isSelected) self.tableView.hidden = YES;
    }
    else
    {
        _currentItem.isSelected = NO;
        item.isSelected = YES;
        _currentItem = item;
    }
}

-(void)addTableViewOnWindow
{
    if (![self.tableView superview])
    {
        UIWindow * window = [HHZKitTool getMainWindow];
        [window addSubview:self.tableView];
        [window bringSubviewToFront:self.tableView];
    }
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    
}

#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInMenu:)]) return [_dataSource numberOfSectionsInMenu:self];
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(menu:numberOfRowsInSection:)]) return [_dataSource menu:self numberOfRowsInSection:section];
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [_dataSource menu:self titleForRowAtIndexPath:indexPath];
    return [HHZDropDownMenuCell configCellWithTableView:tableView title:(str.length > 0 ? str : @"")];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
@end
