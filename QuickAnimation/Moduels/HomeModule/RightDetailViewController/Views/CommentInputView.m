//
//  CommentInputView.m
//  QuickAnimation
//
//  Created by Weilian on 20/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "CommentInputView.h"

@implementation CommentInputView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.placeholder = @"请输入评论";
        _inputTextField.font = [UIFont fontWithName:Font_Name_PFSCRe size:15];
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.layer.cornerRadius = 5.f;
        _inputTextField.layer.masksToBounds = YES;
        [self addSubview:_inputTextField];
        
        _submitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _submitButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        [_submitButton setTitle:@"发送" forState:(UIControlStateNormal)];
        [_submitButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [self addSubview:_submitButton];
        //背景色
        self.backgroundColor = kRGB(251, 227, 76, 1);
    }
    return self;
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
//    CGFloat height = self.frame.size.height;
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).offset(padding.top);
        make.left.mas_equalTo(self.mas_left).offset(padding.left);
        make.right.mas_equalTo(self.submitButton.mas_left).offset(-8);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-padding.bottom);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).offset(padding.top);
        make.width.mas_equalTo(35);
        make.right.mas_equalTo(self.mas_right).offset(-padding.right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-padding.bottom);
    }];
    
}




@end
