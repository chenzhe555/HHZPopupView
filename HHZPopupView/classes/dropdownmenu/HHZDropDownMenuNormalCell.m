//
//  HHZDropDownMenuNormalCell.m
//  HHZPopupView
//
//  Created by 仁和Mac on 2017/9/13.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZDropDownMenuNormalCell.h"

@implementation HHZDropDownMenuNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)configCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath dataArray:(NSArray *)dataArray
{
    static NSString * HHZDropDownMenuNormalCellIdentifier = @"";
    HHZDropDownMenuNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:HHZDropDownMenuNormalCellIdentifier];
    if (!cell)
    {
        cell = [[UINib nibWithNibName:@"HHZDropDownMenuNormalCell" bundle:nil] instantiateWithOwner:nil options:nil][0];
    }
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    return cell;
}

@end
