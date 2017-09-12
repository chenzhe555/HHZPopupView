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

-(CGFloat)menu:(HHZDropDownMenu *)menu heightForFooterInSection:(NSInteger)section;

-(UIView *)menu:(HHZDropDownMenu *)menu viewForFooterInSection:(NSInteger)section;

-(void)menu:(HHZDropDownMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol HHZDropDownMenuDataSource <NSObject>
@required
//顶部显示的文字数组
-(NSArray *)dlTopMenus;

//显示多少Section
-(NSInteger)numberOfSectionsInMenu:(HHZDropDownMenu *)menu;

//每个Section多少Row
-(NSInteger)menu:(HHZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section;

-(NSString *)menu:(HHZDropDownMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath;

-(UITableViewCell *)menu:(HHZDropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HHZDropDownMenu : UIView
@property (nonatomic, assign) id<HHZDropDownMenuDelegate> delegate;
@property (nonatomic, assign) id<HHZDropDownMenuDataSource> dataSource;

//当前选中的Index
@property (nonatomic, assign) NSInteger currentIndex;

-(instancetype)initWithPoint:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
