//
//  SearchViewController.h
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SearchStatus) {
    
    SearchBeforeStatus,
    SearchingStatus,
    SearchResultStatus,
};

@interface SearchViewController : BaseViewController

@property(nonatomic,assign) SearchStatus searchStatus;//搜索状态

@end

NS_ASSUME_NONNULL_END
