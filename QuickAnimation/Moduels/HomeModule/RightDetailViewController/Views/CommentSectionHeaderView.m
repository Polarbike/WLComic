//
//  CommentSectionHeaderView.m
//  QuickAnimation
//
//  Created by Weilian on 20/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "CommentSectionHeaderView.h"
#import "CommentModel.h"


@implementation CommentSectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        _userIcon = [[UIImageView alloc] init];
        _userIcon.layer.cornerRadius = 14.f;
        _userIcon.layer.masksToBounds = YES;
        [_backView addSubview:_userIcon];
        _userName = [[UILabel alloc] init];
        _userName.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        _userName.textColor = kRGB(40, 40, 40, 1);
        _userName.textAlignment = NSTextAlignmentLeft;
        [_backView addSubview:_userName];
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:12];
        _commentLabel.textColor = kRGB(60, 60, 60, 1);
        [_backView addSubview:_commentLabel];
        //回复按钮
        _replyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _replyButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:10];
        [_replyButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [_replyButton setImage:[UIImage imageNamed:@"praise"] forState:(UIControlStateNormal)];
        [_backView addSubview:_replyButton];
        //举报按钮
        _reportButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reportButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:10];
        [_reportButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [_reportButton setTitle:@"举报" forState:(UIControlStateNormal)];
        [_backView addSubview:_reportButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).and.offset(-5);
    }];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.backView.mas_top).and.offset(padding.top);
        make.left.mas_equalTo(self.backView.mas_left).and.offset(padding.left);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.centerY.mas_equalTo(self.userIcon.mas_centerY);
        make.left.mas_equalTo(self.userIcon.mas_right).and.offset(8);
        make.right.mas_equalTo(self.mas_right).and.offset(-padding.left);
        make.height.mas_equalTo(20);
    }];
//    self.commentLabel.preferredMaxLayoutWidth = (self.frame.size.width -20);
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //这里需要判断自适应高度
        make.top.mas_equalTo(self.userIcon.mas_bottom).and.offset(8);
        make.left.mas_equalTo(self.userIcon.mas_centerX).and.offset(8);
        make.right.mas_equalTo(self.mas_right).and.offset(-padding.left);
        make.bottom.mas_equalTo(self.backView.mas_bottom).and.offset(-28);
    }];
    //
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.right.mas_equalTo(self.mas_right).and.offset(-53);
        make.bottom.mas_equalTo(self.backView.mas_bottom).and.offset(-4);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(20);
    }];
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.right.mas_equalTo(self.mas_right).and.offset(-8);
        make.bottom.mas_equalTo(self.backView.mas_bottom).and.offset(-4);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(20);
    }];
    self.backgroundColor = kRGB(247, 247, 247, 1);
}

//重写set model方法
- (void)setCommentModel:(CommentModel *)commentModel {
    
    _commentModel = commentModel;
    _commentModel = commentModel;//userIcon.png
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:commentModel.face] placeholderImage:[UIImage imageNamed:@"userIcon"]];
    _userName.text = commentModel.nickname;
    _commentLabel.text = commentModel.content_filter;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
