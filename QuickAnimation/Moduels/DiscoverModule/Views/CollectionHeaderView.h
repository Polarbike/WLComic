//
//  CollectionHeaderView.h
//  QuickAnimation
//
//  Created by Weilian on 09/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;

NS_ASSUME_NONNULL_BEGIN

@interface CollectionHeaderView : UICollectionReusableView

@property(nonatomic,strong) SDCycleScrollView *bannerView;


@end

NS_ASSUME_NONNULL_END
