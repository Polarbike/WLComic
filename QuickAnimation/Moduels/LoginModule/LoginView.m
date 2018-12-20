//
//  LoginView.m
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //人物照片
        _personImage = [[UIImageView alloc] init];
        _personImage.image = [UIImage imageNamed:@"ic_login_invisible_171x137_"];
        [self addSubview:_personImage];
        //关闭页面按钮
        _closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeButton setImage:[UIImage imageNamed:@"ic_nav_close_normal_16x16_"] forState:(UIControlStateNormal)];
        [_closeButton setImage:[UIImage imageNamed:@"ic_nav_close_pressed_16x16_"] forState:(UIControlStateSelected)];
        [self addSubview:_closeButton];
        //titlelabel
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kRGB(40, 40, 40, 1);
        _titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"登录/注册漫画";
        [self addSubview:_titleLabel];
        //输入框
        _nameTextFiled = [[UITextField alloc] init];
        _nameTextFiled.backgroundColor = [UIColor whiteColor];
        _nameTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextFiled.placeholder = @"请输入用户名";
        _nameTextFiled.textColor = kRGB(40, 40, 40, 1);
        _nameTextFiled.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
        [self addSubview:_nameTextFiled];
        //密码输入
        _passWordTF = [[UITextField alloc] init];
        _passWordTF.backgroundColor = [UIColor whiteColor];
        _passWordTF.borderStyle = UITextBorderStyleRoundedRect;
        _passWordTF.placeholder = @"请输入密码";
        _passWordTF.secureTextEntry = YES;
        _passWordTF.textColor = kRGB(40, 40, 40, 1);
        _passWordTF.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
        [self addSubview:_passWordTF];
        //登录按钮
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginButton.backgroundColor = [UIColor whiteColor];
//        _loginButton.borderStyle = UITextBorderStyleRoundedRect;
//        _loginButton.placeholder = @"请输入密码";
        [_loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
//        _loginButton.titleLabel.textColor = kRGB(40, 40, 40, 1);
        [_loginButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [_loginButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        _loginButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
        [self addSubview:_loginButton];
        //
        _registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
        [_registerButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [_registerButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        _registerButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        [self addSubview:_registerButton];
        //
        _forgetPWButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_forgetPWButton setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        [_forgetPWButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [_forgetPWButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        _forgetPWButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        [self addSubview:_forgetPWButton];
    }
    
    return self;
}
//布局
- (void)layoutSubviews {
    
    WeakSelf(self);
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.mas_top).and.offset(30);
        make.left.mas_equalTo(weakSelf.mas_left).and.offset(20);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    [self.nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.mas_equalTo(weakSelf.mas_left).and.offset(40);
        make.right.mas_equalTo(weakSelf.mas_right).and.offset(-40);
        make.center.equalTo(weakSelf).and.offset(-20);
        make.height.mas_equalTo(36);
    }];
    [self.personImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.bottom.mas_equalTo(weakSelf.nameTextFiled.mas_top);
        make.centerX.mas_equalTo(weakSelf);
        make.height.mas_equalTo(180);
        make.width.mas_equalTo(120);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.closeButton.mas_top);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.width.mas_equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(44);
    }];
    [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.nameTextFiled.mas_bottom).and.offset(20);
        make.left.mas_equalTo(weakSelf.nameTextFiled.mas_left);
        make.width.mas_equalTo(weakSelf.nameTextFiled.mas_width);
        make.height.mas_equalTo(36);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.passWordTF.mas_bottom).and.offset(30);
        make.left.mas_equalTo(weakSelf.passWordTF.mas_left);
        make.width.mas_equalTo(weakSelf.passWordTF.mas_width);
        make.height.mas_equalTo(36);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.loginButton.mas_bottom).and.offset(16);
        make.left.mas_equalTo(weakSelf.loginButton.mas_left);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [self.forgetPWButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(weakSelf.loginButton.mas_bottom).and.offset(16);
        make.right.mas_equalTo(weakSelf.loginButton.mas_right);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if ([self.nameTextFiled isFirstResponder]) {
        
        [self.nameTextFiled resignFirstResponder];
    }
    if ([self.passWordTF isFirstResponder]) {
        
        [self.passWordTF resignFirstResponder];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
