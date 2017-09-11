//
//  HHZDropDownMenuItem.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHZDropDownMenuItemDelegate <NSObject>
@optional
-(void)dlTapItemAtIndex:(NSInteger)index;

@end

@interface HHZDropDownMenuItem : UIView
//当前是否被选中
@property (nonatomic, assign) BOOL isSelected;
//当前Item索引值
@property (nonatomic, assign) NSInteger index;

-(void)configItemTitle:(NSString *)title index:(NSInteger)index delegate:(id<HHZDropDownMenuItemDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
