//
//  MineTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _itemLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
