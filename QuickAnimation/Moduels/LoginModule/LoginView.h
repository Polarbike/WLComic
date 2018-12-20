//
//  LoginView.h
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property(nonatomic,strong) UIImageView *personImage;//

@property(nonatomic,strong) UIButton *closeButton;//关掉登录页面按钮
@property(nonatomic,strong) UILabel *titleLabel;//标题label

@property(nonatomic,strong) UITextField *nameTextFiled;

@property(nonatomic,strong) UITextField *passWordTF;

@property(nonatomic,strong) UIButton *loginButton;//关掉登录页面按钮
@property(nonatomic,strong) UIButton *registerButton;//关掉登录页面按钮
@property(nonatomic,strong) UIButton *forgetPWButton;//忘记密码按钮


@end

NS_ASSUME_NONNULL_END
