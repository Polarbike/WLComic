//
//  LeftTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 11/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _namelabel.font = [UIFont fontWithName:Font_Name_PFSC size:14];
    _namelabel.textColor = kRGB(40, 40, 40, 1);
    
    _descriptionLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    _descriptionLabel.textColor = kRGB(80, 80, 80, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
