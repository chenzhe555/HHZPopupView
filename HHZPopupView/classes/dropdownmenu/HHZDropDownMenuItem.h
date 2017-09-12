//
//  HHZDropDownMenuItem.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHZDropDownMenuItemModel : NSObject
//显示的标题
@property (nonatomic, copy) NSString * title;
//点击后是否展示更多数据,默认是YES
@property (nonatomic, assign) BOOL isShowMore;

//便利式函数
+(instancetype)generateWithTitle:(NSString *)title;

+(instancetype)generateWithTitle:(NSString *)title isShowMore:(BOOL)isShowMore;
@end

@protocol HHZDropDownMenuItemDelegate <NSObject>
@optional
-(void)dlTapItemAtIndex:(NSInteger)index;

@end

@interface HHZDropDownMenuItem : UIView
//当前是否被选中
@property (nonatomic, assign) BOOL isSelected;
//当前Item索引值
@property (nonatomic, assign) NSInteger index;
//点击后是否展示更多数据,默认是YES
@property (nonatomic, assign) BOOL isShowMore;

-(void)configItemModel:(HHZDropDownMenuItemModel *)model index:(NSInteger)index delegate:(id<HHZDropDownMenuItemDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
