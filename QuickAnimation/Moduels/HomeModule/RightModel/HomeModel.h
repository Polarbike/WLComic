//
//  HomeModel.h
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject

@property(nonatomic,strong) NSMutableArray *comicsData;
@property(nonatomic,assign) long comicType;//
@property(nonatomic,copy) NSString *sortId;//
@property(nonatomic,copy) NSString *titleIconUrl;//
@property(nonatomic,assign) long argType;//
@property(nonatomic,assign) long argValue;//
@property(nonatomic,copy) NSString *itemTitle;//
@property(nonatomic,copy) NSString *a_description;
@property(nonatomic,assign) long canedit;
@property(nonatomic,copy) NSString *argName;

@end

NS_ASSUME_NONNULL_END
