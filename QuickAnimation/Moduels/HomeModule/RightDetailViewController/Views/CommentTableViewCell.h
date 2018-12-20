//
//  CommentTableViewCell.h
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (weak, nonatomic) IBOutlet UITextView *contentText;

@property(nonatomic,strong) CommentModel *commentModel;//评论内容模型

@end

NS_ASSUME_NONNULL_END
