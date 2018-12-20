//
//  CommentListTableViewCell.h
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
NS_ASSUME_NONNULL_BEGIN

@interface CommentListTableViewCell : UITableViewCell


@property(nonatomic,strong) UIImageView *userImage;//用户图像
@property(nonatomic,strong) UILabel *userName;//用户名称
@property(nonatomic,strong) UILabel *contentLabel;//内容label

@property(nonatomic,strong) CommentModel *commentModel;//评论模型

@property(nonatomic,assign) CGFloat cell_height;//

@end

NS_ASSUME_NONNULL_END
