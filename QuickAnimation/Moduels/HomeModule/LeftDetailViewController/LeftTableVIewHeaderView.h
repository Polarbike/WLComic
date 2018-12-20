//
//  LeftTableVIewHeaderView.h
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftTableVIewHeaderView : UIView

@property(nonatomic,strong) UIImageView *backImage;//背景图片登录
@property(nonatomic,strong) UIButton *loginButton;//没登录的时候header view为提醒登录的页面
@property(nonatomic,strong) UIImageView *textImage;//登录提示语
@property(nonatomic,strong) UILabel *focusLabel;//关注label
@property(nonatomic,strong) UILabel *guessLike;//猜你喜欢

- (void)setViewBaseInfoWithBool:(BOOL)status;

@end

NS_ASSUME_NONNULL_END
