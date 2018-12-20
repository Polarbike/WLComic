//
//  RigthDetailTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RigthDetailTableViewCell.h"

@implementation RigthDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tittle.font = [UIFont fontWithName:Font_Name_PFSC size:16];
    self.tittle.textColor = kRGB(40, 40, 40, 1);
    
    self.content.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    self.content.textColor = kRGB(40, 40, 40, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
