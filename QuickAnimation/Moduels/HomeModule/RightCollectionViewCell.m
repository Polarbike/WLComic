//
//  RightCollectionViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RightCollectionViewCell.h"

@implementation RightCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _nameLabel.font = [UIFont fontWithName:Font_Name_PFSC size:14];
    _nameLabel.textColor = kRGB(40, 40, 40, 1);
    _typeLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    _typeLabel.textColor = kRGB(40, 40, 40, 1);
}

@end
