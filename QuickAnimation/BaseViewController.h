//
//  BaseViewController.h
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController{
    
    MBProgressHUD *hud;
}


@property(nonatomic,strong) NSMutableDictionary *parameter;//默认参数



- (void)showMBProgressHUDWithMessage:(NSString *)message showLabel:(BOOL)isShowLabel isShowTime:(BOOL)isShowTime;
- (void)hideMBProgressHUD;
//根据评论内容计算高度
- (CGFloat)getCommentHeightWithString:(NSString *)string;
//获取用户信息字典
- (NSDictionary *)getUserInfoDictionary;
//更新用户信息字典
- (void)updateUserInfoWithDictionary:(NSDictionary *)dic;
//
- (void)showAlertHUDWithMessage:(NSString *)message showView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
