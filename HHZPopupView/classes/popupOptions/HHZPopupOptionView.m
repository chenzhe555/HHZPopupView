//
//  HHZPopupOptionView.m
//  HHZPopupView
//
//  Created by 陈哲是个好孩子 on 2017/7/31.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZPopupOptionView.h"
#import <HHZBaseClass/HHZLabel.h>
#import <HHZCategory/UIView+HHZCategory.h>

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
//正常文字颜色
@property (nonatomic, strong) UIColor * normalTitleColor;
//选中的文字颜色
@property (nonatomic, strong) UIColor * selectedTitleColor;
//是否被按下，按下后有颜色变化效果
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation HHZPopupOptionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSelected = NO;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (frame.size.width > 0)
    {
        CGFloat imgX = (frame.size.width - self.imgView.width - (self.imgView.width > 0 ? _betweenSpace : 0) - self.titleLabel.width)/2;
        
        self.imgView.frame = CGRectMake(imgX, (frame.size.height - self.imgView.height)/2, self.imgView.width, self.imgView.height);
        
        CGFloat labelX = self.imgView.width > 0 ? self.imgView.xPlusWidth + _betweenSpace : self.imgView.xPlusWidth;
        self.titleLabel.frame = CGRectMake(labelX, (frame.size.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
    }
}

-(void)configBGNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    if (!normalColor) return;
    
    self.backgroundColor = _normalBGColor;
    _normalBGColor = normalColor;
    _selectedBGColor = selectedColor ? selectedColor : _normalBGColor;
    
    //暂时不加入文字也变色的情况，不然太多种可能性了
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
//    if (image)
//    {
//        self.titleLabel.frame = CGRectMake(_leftSpace + _maxImageWidth + _betweenSpace, (self.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
//    }
//    else
//    {
//        self.titleLabel.frame = CGRectMake(_leftSpace, (self.height - self.titleLabel.height)/2, self.titleLabel.width, self.titleLabel.height);
//    }
}


-(CGFloat)getOptionLabelWidth
{
    return _titleLabel.width;
}

-(CGFloat)getOptionLabelHeight
{
    return _titleLabel.height;
}


#pragma mark 点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self changeSelectedColor:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self changeSelectedColor:NO];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self changeSelectedColor:NO];
}

-(void)changeSelectedColor:(BOOL)isBegin
{
    if (isBegin)
    {
        if (!_isSelected)
        {
            self.backgroundColor = _selectedBGColor;
            _isSelected = YES;
        }
    }
    else
    {
        if (_isSelected)
        {
            self.backgroundColor = _normalBGColor;
            _isSelected = NO;
        }
    }
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
