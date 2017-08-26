//
//  HHZPopupOptionsView.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHZOptionsViewTopShape.h"

//目前只支持三角形
typedef NS_ENUM(NSInteger,HHZPopupOptionsViewTopShapeLocation){
    HHZPopupOptionsViewTopShapeLocationAutomatic = 1101,    //自动调节
    HHZPopupOptionsViewTopShapeLocationLeft,        //左
    HHZPopupOptionsViewTopShapeLocationCenter,      //中
    HHZPopupOptionsViewTopShapeLocationRight        //右
};

NS_ASSUME_NONNULL_BEGIN

@interface HHZPopupOptionsView : UIView
//阴影背景
@property (nonatomic, strong) UIView * shadowView;
//Buttons的父视图
@property (nonatomic, strong) UIView * bgView;
//顶部形状
@property (nonatomic, strong) HHZOptionsViewTopShape * topShape;
//显示的动画时间
@property (nonatomic, assign) CGFloat appearDur;
//消失的动画时间
@property (nonatomic, assign) CGFloat disappearDur;
//每个Item的高度
@property (nonatomic, assign) CGFloat itemHeight;
//每个Item的宽度
@property (nonatomic, assign) CGFloat itemWidth;
//左边的间隙
@property (nonatomic, assign) CGFloat leftSpace;
//右边的间隙
@property (nonatomic, assign) CGFloat rightSpace;
//图片和文字同时存在时候的间隙
@property (nonatomic, assign) CGFloat betweenSpace;
//上下的间隙
@property (nonatomic, assign) CGFloat topSpace;
//文字颜色
@property (nonatomic, strong) UIColor * titleColor;
//文字字体
@property (nonatomic, strong) UIFont * titleFont;
//Item选中颜色
@property (nonatomic, strong) UIColor * bgSelectedColor;

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
@end



NS_ASSUME_NONNULL_END
