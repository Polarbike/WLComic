//
//  ReportView.m
//  QuickAnimation
//
//  Created by Weilian on 26/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ReportView.h"

@implementation ReportView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backButton setImage:[UIImage imageNamed:@"ic_nav_back_normal_11x19_"] forState:(UIControlStateNormal)];
        [self addSubview:_backButton];
        
        _submitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_submitButton setTitle:@"提交" forState:(UIControlStateNormal)];
        _submitButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        [_submitButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [self addSubview:_submitButton];
        
        _inputView = [[UITextView alloc] init];
        _inputView.backgroundColor = kRGB(245, 245, 245, 1);
        _inputView.text = @"请输入举报原因...";
        _inputView.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        _inputView.textColor = kRGB(40, 40, 40, 1);
        [self addSubview:_inputView];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).offset(padding.top+34);
        make.left.mas_equalTo(self.mas_left).offset(padding.left);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(23);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).offset(padding.top+34);
        make.right.mas_equalTo(self.mas_right).offset(-padding.right);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.backButton.mas_top).offset(padding.top+44);
        make.left.mas_equalTo(self.mas_left).offset(padding.left);
        make.right.mas_equalTo(self.mas_right).offset(-padding.right);
        make.height.mas_equalTo(180);
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
