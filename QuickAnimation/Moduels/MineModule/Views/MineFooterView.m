//
//  MineFooterView.m
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MineFooterView.h"

@implementation MineFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _logoutButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_logoutButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
        // 加载拉伸的图片bg_button_login_longest_10x10_
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
        [_logoutButton setBackgroundImage:newImage forState:(UIControlStateNormal)];
        [self addSubview:_logoutButton];
    }
    
    return self;
}


- (void)layoutSubviews {
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).and.offset(8);
        make.left.mas_equalTo(self.mas_left).and.offset(20);
        make.right.mas_equalTo(self.mas_right).and.offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).and.offset(-8);
    }];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
