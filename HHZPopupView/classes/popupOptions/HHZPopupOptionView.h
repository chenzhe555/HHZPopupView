//
//  HHZPopupOptionView.h
//  HHZPopupView
//
//  Created by 陈哲是个好孩子 on 2017/7/31.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHZPopupOptionView : UIView

@property (nonatomic, assign) NSInteger itemIndex;
#pragma mark Required
/**
 *  配置Item显示的基本信息：文本和图片
 */
-(void)configTitle:(NSString *)title image:(UIImage * _Nullable)image titleColor:(UIColor * _Nullable)titleColor font:(UIFont * _Nullable)font;

#pragma mark Optional
/**
 *  配置Item的正常背景颜色和选中的背景颜色
 */
-(void)configBGNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;
/**
 *  配置Item的间隙基本信息
 */
-(void)configLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace betweenSpace:(CGFloat)betweenSpace maxImageWidth:(CGFloat)maxImageWidth;
/**
 *  获取文本的宽度
 */
-(CGFloat)getOptionLabelWidth;
/**
 *  获取文本的高度
 */
-(CGFloat)getOptionLabelHeight;

@end

NS_ASSUME_NONNULL_END
