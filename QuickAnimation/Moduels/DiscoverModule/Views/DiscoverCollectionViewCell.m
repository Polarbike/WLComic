//
//  DiscoverCollectionViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 03/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "DiscoverCollectionViewCell.h"

@implementation DiscoverCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DiscoverCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _topLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
    _topLabel.textColor = kRGB(40, 40, 40, 1);
//    _bottomLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
//    _bottomLabel.textColor = kRGB(80, 80, 80, 1);
//    _shortDescription.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
//    _shortDescription.textColor = kRGB(80, 80, 80, 1);
}

@end
