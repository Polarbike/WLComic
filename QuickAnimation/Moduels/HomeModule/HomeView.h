//
//  HomeView.h
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeView : UIScrollView

@property(nonatomic,strong) UITableView *leftTableView;//首页左侧tableView

@property(nonatomic,strong) UICollectionView *rightCollectionView;//首页右侧tableView

@end

NS_ASSUME_NONNULL_END
