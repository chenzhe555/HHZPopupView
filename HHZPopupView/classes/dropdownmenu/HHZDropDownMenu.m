//
//  HHZDropDownMenu.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZDropDownMenu.h"
#import <HHZUtils/HHZKitTool.h>

@interface HHZDropDownMenu ()<HHZDropDownMenuItemDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * menusArray;
@property (nonatomic, strong) HHZDropDownMenuItem * currentItem;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, assign) CGPoint orginPoint;
@end

@implementation HHZDropDownMenu

-(instancetype)initWithPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _currentIndex = 0;
        _orginPoint = point;
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
    
    UIView * vie = [[UIView alloc] init];
    vie.backgroundColor = [UIColor lightGrayColor];
    vie.frame = CGRectMake(0, self.bounds.size.height - 0.5f, self.bounds.size.width, 0.5f);
    [self addSubview:vie];
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIWindow * window = [HHZKitTool getMainWindow];
    self.tableView.frame = CGRectMake(_orginPoint.x, _orginPoint.y + self.bounds.size.height, self.bounds.size.width, window.bounds.size.height - _orginPoint.y - self.bounds.size.height);
    
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
    return [_dataSource menu:self cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [_delegate menu:self heightForFooterInSection:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [_delegate menu:self viewForFooterInSection:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end