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

typedef NS_ENUM(NSInteger,HHZDropDownMenuType) {
    HHZDropDownMenuTypeNormal = 300
};

@protocol HHZDropDownMenuDelegate <NSObject>

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

@end

@interface HHZDropDownMenu : UIView
@property (nonatomic, assign) id<HHZDropDownMenuDelegate> delegate;
@property (nonatomic, assign) id<HHZDropDownMenuDataSource> dataSource;
@property (nonatomic, assign) HHZDropDownMenuType type;

//当前选中的Index
@property (nonatomic, assign) NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
