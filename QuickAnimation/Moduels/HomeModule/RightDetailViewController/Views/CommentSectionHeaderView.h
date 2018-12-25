//
//  CommentSectionHeaderView.h
//  QuickAnimation
//
//  Created by Weilian on 20/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;

NS_ASSUME_NONNULL_BEGIN

@interface CommentSectionHeaderView : UIView



@property(nonatomic,strong) UIView *backView;//背景视图

@property(nonatomic,strong) UIImageView *userIcon;//用户头像
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *commentLabel;//评论内容label

@property(nonatomic,strong) CommentModel *commentModel;//评论内容模型

@property(nonatomic,strong) UIButton *replyButton;//回复按钮
@property(nonatomic,strong) UIButton *reportButton;//举报按钮

@end

NS_ASSUME_NONNULL_END
