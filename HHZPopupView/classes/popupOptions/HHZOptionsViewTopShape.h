//
//  HHZOptionsViewTopShape.h
//  HHZPopupView
//
//  Created by 陈哲是个好孩子 on 2017/7/31.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HHZOptionsViewTopShapeDirection) {
    HHZOptionsViewTopShapeDirectionTop = 130,   //尖角向上
    HHZOptionsViewTopShapeDirectionRight,       //尖角向右
    HHZOptionsViewTopShapeDirectionBottom,      //尖角向下
    HHZOptionsViewTopShapeDirectionLeft         //尖角向左
};

NS_ASSUME_NONNULL_BEGIN

@interface HHZOptionsViewTopShape : UIView
/**
 *  填充颜色
 */
@property (nonatomic, strong) UIColor * fillColor;
/**
 *  边缘画笔颜色
 */
@property (nonatomic, strong) UIColor * lineColor;
/**
 * 尖角方向（默认向上）
 */
@property (nonatomic, assign) HHZOptionsViewTopShapeDirection shapeDirection;
@end

NS_ASSUME_NONNULL_END
