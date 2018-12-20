//
//  EditUserViewController.h
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//


@protocol EditUserInfoDelegate <NSObject>

- (void)getEditUserImage:(UIImage *)image;
- (void)getUserNickName:(NSString *)string;

@end

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditUserViewController : BaseViewController

@property(nonatomic,strong) UIImage *image;//用户头像
@property(nonatomic,strong) NSString *userName;//昵称名字

@property(nonatomic,weak) id<EditUserInfoDelegate> editDelegate;//编辑a代理

@end

NS_ASSUME_NONNULL_END
