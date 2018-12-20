//
//  RightSectionHeaderView.h
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightSectionHeaderView : UICollectionReusableView

@property(nonatomic,strong) UIImageView *cellIcon;//cellicon
@property(nonatomic,strong) UILabel *cellTittle;//celltittle
@property(nonatomic,strong) UIButton *moreButton;//更多

@end

NS_ASSUME_NONNULL_END
