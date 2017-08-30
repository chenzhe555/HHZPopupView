//
//  HHZPopupOptionsView.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/7/30.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZPopupOptionsView.h"
#import "HHZPopupOptionView.h"
#import <HHZUtils/HHZKitTool.h>
#import <HHZCategory/UIView+HHZCategory.h>

static CGFloat shapeWidth = 15.0f;

@interface HHZPopupOptionsView ()

@end

@implementation HHZPopupOptionsView

#pragma mark 配置基本信息
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        if (!window)
        {
            window = [[UIApplication sharedApplication].windows lastObject];
        }
        
        self.frame = window.bounds;
        
        self.shadowView = [[UIView alloc] init];
        self.shadowView.frame = self.bounds;
        self.shadowView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
        [self addSubview:self.shadowView];
        
        self.bgView = [[UIView alloc] init];
        [self.shadowView addSubview:self.bgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelfHidden)];
        [self addGestureRecognizer:tap];
        
        //设置基本参数信息
        _appearDur = 0.5f;
        _disappearDur = 0.5f;
        _itemHeight = 40.0f;
        _leftSpace = 15.0f;
        _rightSpace = 15.0f;
        _betweenSpace = 10.0f;
        _topSpace = 5.0f;
        _titleColor = [UIColor whiteColor];
        _titleFont = [UIFont systemFontOfSize:14.0f];
        
        [window addSubview:self];
        [window bringSubviewToFront:self];
    }
    return self;
}

#pragma mark 对外调用时间
-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray point:(CGPoint)point
{
    [self createbgViewTitleArray:titleArray imageArray:imageArray point:point shapeLocation:HHZPopupOptionsViewTopShapeLocationRight];
}

-(void)showPopupOptionsViewTitle:(NSArray *)titleArray imageArray:(NSArray *)imageArray shapeLocation:(HHZPopupOptionsViewTopShapeLocation)shapeLocation point:(CGPoint)point
{
    [self createbgViewTitleArray:titleArray imageArray:imageArray point:point shapeLocation:shapeLocation];
}

#pragma mark 创建视图
-(void)createbgViewTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray point:(CGPoint)point shapeLocation:(HHZPopupOptionsViewTopShapeLocation)shapeLocation
{
    if (!titleArray || titleArray.count == 0) return;
    
    CGFloat maxImageWidth = 0.0f;
    CGFloat maxTitleWidth = 0.0f;
    CGFloat maxImageHeight = 0.0f;
    CGFloat maxTitleHeight = 0.0f;
    CGFloat bgViewWidth = 0.0f;
    
    BOOL isImageExist = (imageArray && imageArray.count != 0 && imageArray.count == titleArray.count);
    
    //获取图片最大宽高度
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
        optionView.tag = i;
        optionView.userInteractionEnabled = YES;
        [optionView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOptionView:)]];
        
        [self.bgView addSubview:optionView];
        
        maxTitleWidth = MAX(maxTitleWidth, [optionView getOptionLabelWidth]);
        maxTitleHeight = MAX(maxTitleHeight, [optionView getOptionLabelHeight]);
    }
    
    //如果设置item高度和宽度，则根据外面的来
    CGFloat maxItemHeight = 0;
    if (_itemHeight > 0) maxItemHeight = _itemHeight;
    else maxImageHeight = _topSpace * 2 + MAX(maxTitleHeight,maxImageHeight);
    
    NSInteger index = 0;
    
    CGFloat itemRealWidth = 0;
    for (UIView * vie in self.bgView.subviews)
    {
        if ([vie isKindOfClass:[HHZPopupOptionView class]])
        {
            index = ((HHZPopupOptionView *)vie).itemIndex;
            if (isImageExist)
            {
                if (self.itemWidth > 0) itemRealWidth = self.itemWidth;
                else itemRealWidth = _leftSpace + _rightSpace + _betweenSpace + maxTitleWidth + maxImageWidth;
                vie.frame = CGRectMake(vie.x, index * maxItemHeight, itemRealWidth, maxItemHeight);
            }
            else
            {
                if (self.itemWidth > 0) itemRealWidth = self.itemWidth;
                else itemRealWidth = _leftSpace + _rightSpace + maxTitleWidth;
                vie.frame = CGRectMake(vie.x, index * maxItemHeight, itemRealWidth, maxItemHeight);
            }
            
            if (bgViewWidth == 0.0) bgViewWidth = vie.width;
        }
    }
    
    //最后再根据文本和图片实际最大宽高值设置frame
    self.bgView.frame = CGRectMake(0, 0, bgViewWidth, maxItemHeight * titleArray.count);
    
    
    //添加三角形,如果是自动模式的话，需要特殊处理
    if (shapeLocation == HHZPopupOptionsViewTopShapeLocationAutomatic)
    {
        [self handlePointAutomatic:point];
    }
    else
    {
        [self addShape:shapeLocation point:point];
    }
    
    self.bgView.layer.cornerRadius = 5.0f;
    self.bgView.layer.masksToBounds = YES;
}

-(void)addShape:(HHZPopupOptionsViewTopShapeLocation)shapeLocation point:(CGPoint)point
{
    //shapeWidth 和 图形到bgVie左右间隙一样
    switch (shapeLocation) {
        case HHZPopupOptionsViewTopShapeLocationLeft:
        {
            self.topShape.frame = CGRectMake(point.x - shapeWidth/2.0f, point.y, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.x - shapeWidth, self.topShape.y + shapeWidth, self.bgView.width, self.bgView.height);
        }
            break;
        case HHZPopupOptionsViewTopShapeLocationCenter:
        {
            self.topShape.frame = CGRectMake(point.x - shapeWidth/2.0f, point.y, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.x - self.bgView.width/2.0f, self.topShape.y + shapeWidth, self.bgView.width, self.bgView.height);
            
        }
            break;
        case HHZPopupOptionsViewTopShapeLocationRight:
        {
            self.topShape.frame = CGRectMake(point.x - shapeWidth/2.0f, point.y, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.x + 2 * shapeWidth - self.bgView.width, self.topShape.y + shapeWidth, self.bgView.width, self.bgView.height);
        }
            break;
        default:
            break;
    }
    [self.topShape setNeedsDisplay];
}

-(void)handlePointAutomatic:(CGPoint)point
{
    self.topShape.shapeDirection = HHZOptionsViewTopShapeDirectionTop;
    //粗略将就一下，还有很多临界条件未考虑
    if (point.x <= self.bgView.width)
    {
        self.topShape.shapeDirection = HHZOptionsViewTopShapeDirectionLeft;
        if (point.y >= (self.shadowView.height - self.bgView.height))
        {
            self.topShape.frame = CGRectMake(point.x, point.y - shapeWidth/2.0f, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.x + shapeWidth, self.topShape.yPlushHeight + shapeWidth - self.bgView.height, self.bgView.width, self.bgView.height);
        }
        else
        {
            self.topShape.frame = CGRectMake(point.x, point.y - shapeWidth/2.0f, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.x + shapeWidth, self.topShape.y - shapeWidth, self.bgView.width, self.bgView.height);
        }
    }
    else
    {
        if (self.shadowView.height - point.y >= self.bgView.height)
        {
            self.topShape.shapeDirection = HHZOptionsViewTopShapeDirectionTop;
            self.topShape.frame = CGRectMake(point.x - shapeWidth/2.0f, point.y, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.xPlusWidth + shapeWidth - self.bgView.width, self.topShape.yPlushHeight, self.bgView.width, self.bgView.height);
        }
        else
        {
            self.topShape.shapeDirection = HHZOptionsViewTopShapeDirectionBottom;
            self.topShape.frame = CGRectMake(point.x - shapeWidth/2.0f, point.y - shapeWidth, shapeWidth, shapeWidth);
            self.bgView.frame = CGRectMake(self.topShape.xPlusWidth + shapeWidth - self.bgView.width, self.topShape.y - self.bgView.height, self.bgView.width, self.bgView.height);
        }
    }
    [self.shadowView addSubview:self.topShape];
}

//点击OptionView事件
-(void)tapOptionView:(UITapGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(dlTapOptionAtIndex:)])
    {
        [_delegate dlTapOptionAtIndex:[gesture view].tag];
    }
}

-(HHZOptionsViewTopShape *)topShape
{
    if (!_topShape)
    {
        _topShape = [[HHZOptionsViewTopShape alloc] init];
        [self.shadowView addSubview:_topShape];
    }
    return _topShape;
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

#pragma mark 事件触发
-(void)tapSelfHidden
{
    if (_delegate && [_delegate respondsToSelector:@selector(dlTapToHidden)])
    {
        [_delegate dlTapToHidden];
    }
}

@end

