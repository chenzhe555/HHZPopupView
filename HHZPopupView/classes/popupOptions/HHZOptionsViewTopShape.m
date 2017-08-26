//
//  HHZOptionsViewTopShape.m
//  HHZPopupView
//
//  Created by 陈哲是个好孩子 on 2017/7/31.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZOptionsViewTopShape.h"

@implementation HHZOptionsViewTopShape
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _lineColor = [UIColor whiteColor];
        _fillColor = [UIColor whiteColor];
        _shapeDirection = HHZOptionsViewTopShapeDirectionTop;
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGPoint points[3];
    switch (_shapeDirection) {
        case HHZOptionsViewTopShapeDirectionTop:
        {
            points[0] = CGPointMake(rect.size.width/2.0f, 0);
            points[1] = CGPointMake(0, rect.size.height);
            points[2] = CGPointMake(rect.size.width, rect.size.height);
        }
            break;
        case HHZOptionsViewTopShapeDirectionRight:
        {
            points[0] = CGPointMake(0, 0);
            points[1] = CGPointMake(rect.size.width, rect.size.height/2.0);
            points[2] = CGPointMake(0, rect.size.height);
        }
            break;
        case HHZOptionsViewTopShapeDirectionBottom:
        {
            points[0] = CGPointMake(0, 0);
            points[1] = CGPointMake(rect.size.width, 0);
            points[2] = CGPointMake(rect.size.width/2.0, rect.size.height);
        }
            break;
        case HHZOptionsViewTopShapeDirectionLeft:
        {
            points[0] = CGPointMake(0, rect.size.height/2.0);
            points[1] = CGPointMake(rect.size.width, 0);
            points[2] = CGPointMake(rect.size.width, rect.size.height);
        }
            break;
            
        default:
            break;
    }
    
    CGContextAddLines(ref, points, 3);
    [_lineColor setStroke];
    [_fillColor setFill];
    CGContextClosePath(ref);
    CGContextDrawPath(ref, kCGPathFillStroke);
}

@end
