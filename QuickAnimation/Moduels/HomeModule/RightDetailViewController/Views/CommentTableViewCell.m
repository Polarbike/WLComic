//
//  CommentTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentModel.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userImage.layer.cornerRadius = 14.f;
    _userImage.layer.masksToBounds = YES;
    _userName.font = [UIFont fontWithName:Font_Name_PFSC size:13];
    _userName.textColor = kRGB(65, 65, 65, 1);
    _contentText.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    _contentText.textColor =  kRGB(105, 105, 105, 1);
    _contentText.userInteractionEnabled = false;
}


//在这里重写commentModel的set方法
- (void)setCommentModel:(CommentModel *)commentModel {
    
    _commentModel = commentModel;//userIcon.png
    [_userImage sd_setImageWithURL:[NSURL URLWithString:commentModel.face] placeholderImage:[UIImage imageNamed:@"userIcon"]];
    _userName.text = commentModel.nickname;
    _contentText.text = commentModel.content_filter;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
