//
//  SearchCollectionViewCell.h
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCollectionViewCell : UICollectionViewCell

extern CGFloat itemHeight;

@property(nonatomic,strong) UIView *backView;//背景图

@property(nonatomic,strong) UILabel *itemLabel;//itemLabel

@end

NS_ASSUME_NONNULL_END
