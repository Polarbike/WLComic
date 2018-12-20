//
//  LeftTableVIewHeaderView.m
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "LeftTableVIewHeaderView.h"

@implementation LeftTableVIewHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _backImage = [[UIImageView alloc] init];
//        _backImage.image = [UIImage imageNamed:@"empty_comic_text"];
//        [self addSubview:_backImage];
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
        // 加载拉伸的图片
        UIImage *image = [UIImage imageNamed:@"bg_button_login_longest_10x10_"];
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        // 设置端盖的值
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 设置拉伸的模式
        UIImageResizingMode mode = UIImageResizingModeStretch;
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
        [_loginButton setBackgroundImage:newImage forState:(UIControlStateNormal)];
        _loginButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
        _loginButton.titleLabel.textColor = kRGB(40, 40, 40, 1);
        [self addSubview:_loginButton];
        //一句提示登录语
        _textImage = [[UIImageView alloc] init];
        _textImage.image = [UIImage imageNamed:@"empty_comic_text"];
//        [self addSubview:_textImage];
        //
        _focusLabel = [[UILabel alloc] init];
        _focusLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _focusLabel.textColor = kRGB(60, 60, 60, 0.6);
        _focusLabel.textAlignment = NSTextAlignmentCenter;
        _focusLabel.hidden = YES;
        _focusLabel.text = @"快去看漫画关注吧";
        [self addSubview:_focusLabel];
        //
        _guessLike = [[UILabel alloc] init];
        _guessLike.font = [UIFont fontWithName:Font_Name_PFSC size:16];
        _guessLike.textColor = kRGB(245, 188, 69, 1);
        _guessLike.textAlignment = NSTextAlignmentLeft;
        _guessLike.text = @"猜你喜欢";
        [self addSubview:_guessLike];
    }
    return self;
    
}

- (void)layoutSubviews {
    
    CGFloat header_height = self.frame.size.height;
//    _backImage.frame = CGRectMake(0, 0, kSCREEN_Width, header_height);
    _loginButton.frame = CGRectMake((kSCREEN_Width-140)/2, (header_height-32)/2, 140, 32);
    _textImage.frame = CGRectMake(10, self.loginButton.frame.origin.y+36, kSCREEN_Width-20, 46);
    _focusLabel.frame = CGRectMake(40, 40, kSCREEN_Width-80, 16);
    [self.guessLike mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.mas_equalTo(self.mas_left).and.offset(20);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(30);
    }];
}

- (void)setViewBaseInfoWithBool:(BOOL)status {
    
    if (status) {
        
        self.loginButton.hidden = YES;
        self.textImage.hidden = YES;
        self.focusLabel.hidden = NO;
    }else{
        
        self.focusLabel.hidden = YES;
        self.loginButton.hidden = NO;
        self.textImage.hidden = NO;
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
