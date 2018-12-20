//
//  MineHeaderView.h
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView


@property(nonatomic,strong) UIImageView *backImage;//
@property(nonatomic,strong) UIImageView *userImage;//
@property(nonatomic,strong) UIButton *loginBut;//登录按钮,未登录的时候显示登录按钮

- (void)setHeaderViewWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
