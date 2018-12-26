//
//  ReportView.h
//  QuickAnimation
//
//  Created by Weilian on 26/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportView : UIView

@property(nonatomic,strong) UIButton *backButton;//返回按钮
@property(nonatomic,strong) UIButton *submitButton;//提交按钮
@property(nonatomic,strong) UITextView *inputView;//输入视图

@end

NS_ASSUME_NONNULL_END
