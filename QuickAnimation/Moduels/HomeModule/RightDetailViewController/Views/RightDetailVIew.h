//
//  RightDetailVIew.h
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightDetailVIew : UIScrollView

@property(nonatomic,strong) UITableView *detailTableView;//漫画详情tableview
@property(nonatomic,strong) UICollectionView *collectionView;//目录collectionView
@property(nonatomic,strong) UITableView *commentTableView;//评论tableView


@end

NS_ASSUME_NONNULL_END