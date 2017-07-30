//
//  HHZPopupOptionsView.h
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHZPopupOptionsView : UIView

-(void)configBGViewBackgorundColor:(UIColor *)bgColor;

-(void)configSelectedBackgroundColor:(UIColor *)selectedColor;

-(void)configTitleColor:(UIColor *)titleColor;

-(void)configTitleFont:(UIFont *)titleFont;

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray;

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray * _Nullable)imageArray appearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring;

@end

@interface HHZPopupOptionView : UIView

@property (nonatomic, assign) NSInteger itemIndex;

-(void)configBGNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

-(void)configLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace betweenSpace:(CGFloat)betweenSpace maxImageWidth:(CGFloat)maxImageWidth;

-(void)configTitle:(NSString *)title image:(UIImage * _Nullable)image titleColor:(UIColor * _Nullable)titleColor font:(UIFont * _Nullable)font;

-(CGFloat)getOptionLabelWidth;

-(CGFloat)getOptionLabelHeight;
@end


NS_ASSUME_NONNULL_END
