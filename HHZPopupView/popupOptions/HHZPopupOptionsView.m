//
//  HHZPopupOptionsView.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZPopupOptionsView.h"
#import <HHZUtils/HHZKitTool.h>
#import <HHZBaseClass/HHZLabel.h>
#import <HHZCategory/UIView+HHZCategory.h>

@interface HHZPopupOptionsView ()
@property (nonatomic, strong) UIView * bgView;
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
@end

@implementation HHZPopupOptionsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIWindow * window = [HHZKitTool getMainWindow];
        self.frame = window.bounds;
        [window addSubview:self];
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelfHidden)];
        [self addGestureRecognizer:tap];
        
        _appearDur = 0.5f;
        _disappearDur = 0.5f;
        _itemHeight = 32.0f;
    }
    return self;
}

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    [self showPopupOptionsViewTitle:titleArray imageArray:imageArray appearDuring:_appearDur disappearDuring:_disappearDur];
}

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray appearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring
{
    [self configAppearDuring:appearDuring disappearDuring:disappearDuring];
}

-(void)createbgViewTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    if (imageArray && imageArray.count != 0 &&imageArray.count == titleArray.count)
    {
        
    }
    else
    {
        for (int i = 0; i < titleArray.count; ++i)
        {
            HHZPopupOptionView * optionView = [[HHZPopupOptionView alloc] init];
            [optionView configLeftSpace:_leftSpace rightSpace:_rightSpace betweenSpace:_betweenSpace maxImageWidth:0];
            optionView.frame = CGRectMake(0, i * _itemHeight, 0, _itemHeight);
            [optionView configTitle:titleArray[i] image:nil titleColor:nil font:nil];
            [self.bgView addSubview:optionView];
        }
    }
}

#pragma mark 计算文本宽度
-(CGFloat)calculateMaxWidth:(NSArray *)titleArray
{
    CGFloat maxWidth = 0.0f;
    
    return maxWidth;
}

#pragma mark 配置一些基本信息
-(void)configAppearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring
{
    if (appearDuring > 0) _appearDur = appearDuring;
    if (disappearDuring > 0) _disappearDur = disappearDuring;
}

#pragma mark 事件触发
-(void)tapSelfHidden
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

@end

@interface HHZPopupOptionView ()
@property (nonatomic, strong) HHZLabel * titleLabel;
@property (nonatomic, strong) UIImageView * imgView;
//左边的间隙
@property (nonatomic, assign) CGFloat leftSpace;
//右边的间隙
@property (nonatomic, assign) CGFloat rightSpace;
//图片和文字同时存在时候的间隙
@property (nonatomic, assign) CGFloat betweenSpace;
//如果有图片,选出最大尺寸
@property (nonatomic, assign) CGFloat maxImageWidth;
@end

@implementation HHZPopupOptionView

-(void)configLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace betweenSpace:(CGFloat)betweenSpace maxImageWidth:(CGFloat)maxImageWidth
{
    _leftSpace = leftSpace;
    _rightSpace = rightSpace;
    _betweenSpace = betweenSpace;
    _maxImageWidth = maxImageWidth;
}

-(void)configTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    if (font) self.titleLabel.font = font;
    if (titleColor) self.titleLabel.textColor = titleColor;
    
    //计算图片Frame
    if (image)
    {
        CGFloat imgWidth = image.size.width/[UIScreen mainScreen].scale;
        CGFloat imgHeight = image.size.height/[UIScreen mainScreen].scale;
        self.imgView.image = image;
        self.imgView.frame = CGRectMake(_leftSpace, (self.height - imgHeight)/2, imgWidth, imgHeight);
    }
    
    //计算文本的Frame
    self.titleLabel.text = title;
    if (image)
    {
        self.titleLabel.frame = CGRectMake(_leftSpace + _maxImageWidth + _betweenSpace, (self.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
    }
    else
    {
        self.titleLabel.frame = CGRectMake(_leftSpace, (self.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
    }
    
    self.frame = CGRectMake(self.x, self.y, self.titleLabel.xPlusWidth + _rightSpace, self.height);
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[HHZLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectZero;
        [self addSubview:_imgView];
    }
    return _imgView;
}

@end
