//
//  MineHeaderView.m
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#define kUSERIMAGE_width 80

#import "MineHeaderView.h"


@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _userImage = [[UIImageView alloc] init];
        _userImage.layer.cornerRadius = 40;
        _userImage.layer.masksToBounds = YES;
        _userImage.userInteractionEnabled = YES;
        _userImage.image = [UIImage imageNamed:@"ic_personal_avatar_83x83_"];
        [self addSubview:_userImage];
        _loginBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBut setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        _loginBut.titleLabel.font = [UIFont fontWithName:Font_Name_PFSC size:20];
        //_loginBut.textAlignment = NSTextAlignmentCenter;
        //_loginBut.text = @"请登录";/
        [self addSubview:_loginBut];
    }
    self.backgroundColor = kRGB(251, 227, 76, 1);
    return self;
    
}

- (void)layoutSubviews {
    
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置user头像
        make.center.equalTo(self);
        make.width.mas_equalTo(kUSERIMAGE_width);
        make.height.mas_equalTo(kUSERIMAGE_width);
    }];
    [self.loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
        //登录按钮
        make.centerX.equalTo(self.userImage);
        make.top.mas_equalTo(self.userImage.mas_bottom).and.offset(20);
        make.left.mas_equalTo(self.mas_left).and.offset(10);
        make.right.mas_equalTo(self.mas_right).and.offset(-10);
    }];
    
}

- (void)setHeaderViewWithDictionary:(NSDictionary *)dic {
    
    if (!IsNilOrNull(dic)) {
        NSData *imageData = dic[kUserImage];
        //如果字典不为空
//        NSURL *userImage = [NSURL URLWithString:dic[@"avar"]];
        UIImage *userImage = [UIImage imageWithData:imageData];
        self.userImage.image = IsNilOrNull(userImage)?[UIImage imageNamed:@"ic_personal_avatar_83x83_"]:userImage;
        NSString *title = dic[kNickName];
        [self.loginBut setTitle:IsNilOrNull(title)?@"请登录":title forState:(UIControlStateNormal)];
    }else{
        
        self.userImage.image = [UIImage imageNamed:@"ic_personal_avatar_83x83_"];
        [self.loginBut setTitle:@"请登录" forState:(UIControlStateNormal)];
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
