//
//  CommentListTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "CommentListTableViewCell.h"
#import "CommentModel.h"
#import "NSString+Height.h"

@implementation CommentListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _userImage = [[UIImageView alloc] init];
        [self addSubview:_userImage];
        _userName = [[UILabel alloc] init];
        _userName.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        [self addSubview:_userName];
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        [self addSubview:_contentLabel];
        
    }
    return self;
    
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.contentView.mas_top).and.offset(padding.top);
        make.left.mas_equalTo(self.contentView.mas_left).and.offset(padding.left);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.contentView.mas_top).and.offset(padding.top);
        make.left.mas_equalTo(self.userImage.mas_right).and.offset(padding.right);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(22);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.userImage.mas_bottom).and.offset(padding.bottom);
        make.left.mas_equalTo(self.contentView.mas_left).and.offset(8);
        make.width.mas_equalTo(self.contentView.mas_width).and.offset(-16);
        make.height.mas_equalTo(self.cell_height);
    }];
    
}

//在这里重写commentModel的set方法
- (void)setCommentModel:(CommentModel *)commentModel {
    
    _commentModel = commentModel;//userIcon.png
    [_userImage sd_setImageWithURL:[NSURL URLWithString:commentModel.face] placeholderImage:[UIImage imageNamed:@"userIcon"]];
    _userName.text = commentModel.nickname;
    _contentLabel.text = commentModel.content_filter;
    NSString *string = commentModel.content_filter;
//    [_contentLabel sizeToFit];
    CGSize size = [string textSizeWithFont:[UIFont fontWithName:Font_Name_PFSCRe size:14] constrainedToSize:CGSizeMake(kSCREEN_Width-16, MAXFLOAT)];
    self.cell_height = ceilf(size.height)+1;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
