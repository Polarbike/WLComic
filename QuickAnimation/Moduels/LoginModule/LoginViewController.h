//
//  LoginViewController.h
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginStatusDelegate <NSObject>

- (void)getLoginViewLogStatus:(BOOL)status name:(NSString *)name;

@end


NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController


@property(nonatomic,weak) id<LoginStatusDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
