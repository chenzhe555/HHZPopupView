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
//上下的间隙
@property (nonatomic, assign) CGFloat topSpace;
//文字颜色
@property (nonatomic, strong) UIColor * titleColor;
//文字字体
@property (nonatomic, strong) UIFont * titleFont;
//Item选中颜色
@property (nonatomic, strong) UIColor * bgSelectedColor;
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
        _itemHeight = 40.0f;
        _leftSpace = 15.0f;
        _rightSpace = 15.0f;
        _betweenSpace = 10.0f;
        _topSpace = 5.0f;
        _titleColor = [UIColor whiteColor];
        _titleFont = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

-(void)configBGViewBackgorundColor:(UIColor *)bgColor
{
    self.bgView.backgroundColor = bgColor;
}

-(void)configSelectedBackgroundColor:(UIColor *)selectedColor
{
    _bgSelectedColor = selectedColor;
}

-(void)configTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
}

-(void)configTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
}

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    [self showPopupOptionsViewTitle:titleArray imageArray:imageArray appearDuring:_appearDur disappearDuring:_disappearDur];
}

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray appearDuring:(CGFloat)appearDuring disappearDuring:(CGFloat)disappearDuring
{
    [self configAppearDuring:appearDuring disappearDuring:disappearDuring];
    [self createbgViewTitleArray:titleArray imageArray:imageArray];
}

-(void)createbgViewTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    if (!titleArray || titleArray.count == 0) return;
    
    CGFloat maxImageWidth = 0.0f;
    CGFloat maxTitleWidth = 0.0f;
    CGFloat maxImageHeight = 0.0f;
    CGFloat maxTitleHeight = 0.0f;
    CGFloat bgViewWidth = 0.0f;
    
    BOOL isImageExist = (imageArray && imageArray.count != 0 && imageArray.count == titleArray.count);
    
    //获取最大宽度
    if (isImageExist) maxImageWidth = [self calculateMaxImageWidth:imageArray];
    if (isImageExist) maxImageHeight = [self calculateMaxImageHeight:imageArray];
    
    //绘制按钮
    for (int i = 0; i < titleArray.count; ++i)
    {
        HHZPopupOptionView * optionView = [[HHZPopupOptionView alloc] init];
        optionView.itemIndex = i;
        optionView.frame = CGRectMake(0, i * _itemHeight, 0, _itemHeight);
        [optionView configBGNormalColor:self.bgView.backgroundColor selectedColor:_bgSelectedColor];
        [optionView configLeftSpace:_leftSpace rightSpace:_rightSpace betweenSpace:_betweenSpace maxImageWidth:maxImageWidth];
        if (isImageExist)
        {
            [optionView configTitle:titleArray[i] image:imageArray[i] titleColor:_titleColor font:_titleFont];
        }
        else
        {
            [optionView configTitle:titleArray[i] image:nil titleColor:_titleColor font:_titleFont];
        }
        
        [self.bgView addSubview:optionView];
        
        maxTitleWidth = MAX(maxTitleWidth, [optionView getOptionLabelWidth]);
        maxTitleHeight = MAX(maxTitleHeight, [optionView getOptionLabelHeight]);
    }
    
    //赋值整体宽度
    CGFloat maxItemHeight = _topSpace * 2 + MAX(maxTitleHeight,maxImageHeight);
    NSInteger index = 0;
    for (UIView * vie in self.bgView.subviews)
    {
        if ([vie isKindOfClass:[HHZPopupOptionView class]])
        {
            index = ((HHZPopupOptionView *)vie).itemIndex;
            if (isImageExist)
            {
                vie.frame = CGRectMake(vie.x, index * maxItemHeight, _leftSpace + _rightSpace + _betweenSpace + maxTitleWidth + maxImageWidth, maxItemHeight);
            }
            else
            {
                vie.frame = CGRectMake(vie.x, index * maxItemHeight, _leftSpace + _rightSpace + maxTitleWidth, maxItemHeight);
            }
            
            if (bgViewWidth == 0.0) bgViewWidth = vie.width;
        }
    }
    
    self.bgView.frame = CGRectMake(100, 100, bgViewWidth, _itemHeight * titleArray.count);
}

#pragma mark 计算最大宽高度
//计算图片最大宽度
-(CGFloat)calculateMaxImageWidth:(NSArray *)imageArray
{
    CGFloat maxWidth = 0.0f;
    for (UIImage * img in imageArray)
    {
        maxWidth = MAX(maxWidth, img.size.width/[UIScreen mainScreen].scale);
    }
    return maxWidth;
}

//计算图片最大宽高度
-(CGFloat)calculateMaxImageHeight:(NSArray *)imageArray
{
    CGFloat maxHeight = 0.0f;
    for (UIImage * img in imageArray)
    {
        maxHeight = MAX(maxHeight, img.size.height/[UIScreen mainScreen].scale);
    }
    return maxHeight;
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
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self removeFromSuperview];
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
//正常背景颜色
@property (nonatomic, strong) UIColor * normalBGColor;
//选中的背景颜色
@property (nonatomic, strong) UIColor * selectedBGColor;
//底部横线
@property (nonatomic, strong) UIView * bottomView;
@end

@implementation HHZPopupOptionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _normalBGColor = [UIColor whiteColor];
        self.backgroundColor = _normalBGColor;
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomView];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (frame.size.width > 0)
    {
        self.imgView.frame = CGRectMake(self.imgView.x, (frame.size.height - self.imgView.height)/2, self.imgView.width, self.imgView.height);
        self.titleLabel.frame = CGRectMake(self.titleLabel.x, (frame.size.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
        _bottomView.frame = CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5);
    }
}

-(void)configBGNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    if (normalColor)
    {
        _normalBGColor = normalColor;
        self.backgroundColor = _normalBGColor;
    }
    
    if (selectedColor)
    {
        _selectedBGColor = selectedColor;
        _bottomView.backgroundColor = selectedColor;
    }
    else
    {
        _selectedBGColor = _normalBGColor;
    }
    
}

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
}


-(CGFloat)getOptionLabelWidth
{
    return _titleLabel.width;
}

-(CGFloat)getOptionLabelHeight
{
    return _titleLabel.height;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = _selectedBGColor;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = _normalBGColor;
    
    if ([self judgeTouchEnd:[touches anyObject]])
    {
        
    }
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.backgroundColor = _normalBGColor;
    
    if ([self judgeTouchEnd:[touches anyObject]])
    {
        
    }
}


-(BOOL)judgeTouchEnd:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) return YES;
    
    return NO;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[HHZLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
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
