//
//  ReturnDataModel.h
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComicsModel;


NS_ASSUME_NONNULL_BEGIN

@interface ReturnDataModel : NSObject


@property(nonatomic,copy) NSArray *spinnerList;
@property(nonatomic,assign) long page;//
@property(nonatomic,copy) NSDictionary *defaultParameters;//默认参数
@property(nonatomic,copy) NSMutableArray<ComicsModel *> *comics;
@property(nonatomic,assign) BOOL hasMore;//是否还有更多


@end

NS_ASSUME_NONNULL_END
