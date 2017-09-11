//
//  HHZDropDownMenuCell.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/11.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZDropDownMenuCell.h"

@implementation HHZDropDownMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)configCellWithTableView:(UITableView *)tableView title:(NSString *)title
{
    static NSString * HHZDropDownMenuCellIdentifier = @"HHZDropDownMenuCellIdentifier";
    HHZDropDownMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:HHZDropDownMenuCellIdentifier];
    if (!cell)
    {
        cell = [[HHZDropDownMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HHZDropDownMenuCellIdentifier];
    }
    cell.textLabel.text = title;
    return cell;
}

@end
