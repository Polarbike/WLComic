//
//  MoreComicViewController.h
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoreComicViewController : BaseViewController


@property(nonatomic,strong) NSNumber *acrCon;
@property(nonatomic,strong) NSNumber *argValue;
@property(nonatomic,copy) NSString *argName;//
@property(nonatomic,strong) NSNumber *page;//
/*
 [self.parameter setObject:@"0" forKey:@"argCon"];
 [self.parameter setObject:@"topic" forKey:@"argName"];
 [self.parameter setObject:@"8" forKey:@"argValue"];
 [self.parameter setObject:@"1" forKey:@"page"];
 */

@end

NS_ASSUME_NONNULL_END
