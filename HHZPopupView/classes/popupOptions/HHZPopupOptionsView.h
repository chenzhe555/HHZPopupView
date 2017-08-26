//
//  HHZPopupOptionsView.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

//目前只支持三角形
typedef NS_ENUM(NSInteger,HHZPopupOptionsViewTopShapeLocation){
    HHZPopupOptionsViewTopShapeLocationAutomatic = 1101,    //自动调节
    HHZPopupOptionsViewTopShapeLocationLeft,        //左
    HHZPopupOptionsViewTopShapeLocationCenter,      //中
    HHZPopupOptionsViewTopShapeLocationRight        //右
};

NS_ASSUME_NONNULL_BEGIN

@interface HHZPopupOptionsView : UIView
#pragma mark Required
/**
 *  显示Options选项框
    titleArray  文本数组，不为空
    imageArray  图片数组，可以为空
    rect 显示位置
 */
-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray point:(CGPoint)point;
/**
 *  显示Options选项框
    titleArray  文本数组，不为空
    imageArray  图片数组，可以为空
    shapeLocation 顶部图形位置信息
    rect 显示位置
 */
-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray shapeLocation:(HHZPopupOptionsViewTopShapeLocation)shapeLocation point:(CGPoint)point;


#pragma mark Optional
/**
 *  显示Options选项框
    titleArray  文本数组，不为空
    imageArray  图片数组，可以为空
    appearDuring    显示动画时间
    disappearDuring 消失动画时间
    shapeLocation 顶部图形位置信息
    rect 显示位置
 */
-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray appearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring shapeLocation:(HHZPopupOptionsViewTopShapeLocation)shapeLocation point:(CGPoint)point;
/**
 *  显示Options选项框
    titleArray  文本数组，不为空
    imageArray  图片数组，可以为空
    appearDuring    显示动画时间
    disappearDuring 消失动画时间
    rect 显示位置
 */
-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray appearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring point:(CGPoint)point;
/**
 *  设置OptionsView的背景色
 */
-(void)configBGViewBackgorundColor:(UIColor *)bgColor;
/**
 *  设置Item的选中颜色
 */
-(void)configSelectedBackgroundColor:(UIColor *)selectedColor;
/**
 *  设置Item的文本颜色和字体
 */
-(void)configTitleColor:(UIColor * _Nullable)titleColor titleFont:(UIFont * _Nullable)titleFont;
@end



NS_ASSUME_NONNULL_END
