//
//  HHZDropDownMenu.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHZDropDownMenuItem.h"
@class HHZDropDownMenu;

NS_ASSUME_NONNULL_BEGIN

@protocol HHZDropDownMenuDelegate <NSObject>
@optional
-(CGFloat)menu:(HHZDropDownMenu *)menu heightForFooterInSection:(NSInteger)section;

-(UIView *)menu:(HHZDropDownMenu *)menu viewForFooterInSection:(NSInteger)section;

-(void)menu:(HHZDropDownMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark 点击Menu事件
-(void)dlTapTopMenuItemAtIndex:(NSInteger)index isSelected:(BOOL)isSelected;

@end

@protocol HHZDropDownMenuDataSource <NSObject>
@required
//顶部显示的文字数组
-(NSArray<HHZDropDownMenuItemModel *> *)dlTopMenus;

//显示多少Section
-(NSInteger)numberOfSectionsInMenu:(HHZDropDownMenu *)menu;

//每个Section多少Row
-(NSInteger)menu:(HHZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)menu:(HHZDropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(NSString *)menu:(HHZDropDownMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HHZDropDownMenu : UIView
@property (nonatomic, assign) id<HHZDropDownMenuDelegate> delegate;
@property (nonatomic, assign) id<HHZDropDownMenuDataSource> dataSource;
@property (nonatomic, strong) UITableView * tableView;
//选择后是否改变顶部的菜单文字，默认是NO
@property (nonatomic, assign) BOOL isChangeTopItemTitle;

//当前选中的Index
@property (nonatomic, assign) NSInteger currentIndex;

-(instancetype)initWithPoint:(CGPoint)point;

//主动隐藏所有视图
-(void)hiddenAllViews;
@end

NS_ASSUME_NONNULL_END
