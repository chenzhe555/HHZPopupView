//
//  HHZDropDownMenuItem.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZDropDownMenuItem.h"
#import "HHZOptionsViewTopShape.h"
#import <HHZBaseClass/HHZLabel.h>

#define kHHZDropDownMenuItemSpace 5

@interface HHZDropDownMenuItem ()
@property (nonatomic, assign) id<HHZDropDownMenuItemDelegate> delegate;


@property (nonatomic, strong) HHZLabel * titleLabel;
@property (nonatomic, strong) HHZOptionsViewTopShape * shapeView;
@end

@implementation HHZDropDownMenuItem

-(void)configItemTitle:(NSString *)title index:(NSInteger)index delegate:(nonnull id<HHZDropDownMenuItemDelegate>)delegate
{
    _delegate = delegate;
    _index = index;
    
    self.titleLabel.text = title;
    self.titleLabel.frame = CGRectMake((self.frame.size.width - self.titleLabel.bounds.size.width - kHHZDropDownMenuItemSpace - self.shapeView.bounds.size.width)/2, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    self.shapeView.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.bounds.size.width + kHHZDropDownMenuItemSpace, (self.bounds.size.height - self.shapeView.bounds.size.height)/2, self.shapeView.bounds.size.width, self.shapeView.bounds.size.height);
    [self addTapGesture];
}

-(void)addTapGesture
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem)]];
}


-(void)tapItem
{
    if (_delegate && [_delegate respondsToSelector:@selector(dlTapItemAtIndex:)])
    {
        [_delegate dlTapItemAtIndex:_index];
    }
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    [UIView animateWithDuration:0.3f animations:^{
        if (_isSelected) self.shapeView.transform = CGAffineTransformMakeRotation(-M_PI);
        else self.shapeView.transform = CGAffineTransformMakeRotation(0);
    }];
}

#pragma mark 懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[HHZLabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(HHZOptionsViewTopShape *)shapeView
{
    if (!_shapeView)
    {
        _shapeView = [[HHZOptionsViewTopShape alloc] init];
        _shapeView.fillColor = [UIColor blackColor];
        _shapeView.frame = CGRectMake(0, 0, 10, 10);
        [self addSubview:_shapeView];
    }
    return _shapeView;
}

@end
