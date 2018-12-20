//
//  ClassDTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ClassDTableViewCell.h"

@implementation ClassDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _nameLabel.font = [UIFont fontWithName:Font_Name_PFSC size:14];
    _nameLabel.textColor = kRGB(40, 40, 40, 1);
    _autherLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:12];
    _autherLabel.textColor = kRGB(40, 40, 40, 1);
    _typeLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:12];
    _typeLabel.textColor = kRGB(60, 60, 60, 1);
    _descriptionLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:12];
    _descriptionLabel.textColor = kRGB(70, 70, 70, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
