//
//  CommentInputView.h
//  QuickAnimation
//
//  Created by Weilian on 20/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CommentInputVIewStatus) {
    
    InputViewCommentStatus,
    InputViewReplyStatus,
};

NS_ASSUME_NONNULL_BEGIN

@interface CommentInputView : UIView

@property(nonatomic,strong) UITextField *inputTextField;//输入框
@property(nonatomic,strong) UIButton *submitButton;//提交按钮

@property(nonatomic,assign) CommentInputVIewStatus inputStatus;


@end

NS_ASSUME_NONNULL_END
