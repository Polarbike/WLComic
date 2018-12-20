//
//  RegistForgetViewController.h
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

@protocol UserNameDelegate <NSObject>

- (void)getEditUserName:(NSString *)name;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RegistForgetViewController : BaseViewController

@property(nonatomic,assign) BOOL isRegister;//是否是注册用户

@property(nonatomic,weak) id<UserNameDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
