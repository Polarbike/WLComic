//
//  ChapterCollectionViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ChapterCollectionViewCell.h"

@implementation ChapterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ChapterCollectionViewCell" owner:self options:nil];
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
    // Initialization code 通过nib加载视图
    _chapterLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:15];
    _chapterLabel.textColor = kRGB(40, 40, 40, 1);
    //搞定collectionview cell背景问题，漫画详情页，登录注册问题
}

@end
