//
//  ComicsModel.h
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicsModel : NSObject



/*
 author = "\U5317\U4eac\U4e09\U798f";
 comicId = 149027;
 conTag = 1543908365;
 cover = "http://cover.u17i.com/2017/04/12340708_1492150647_68H6N9T2HvVh.sbig.jpg";
 description = "!\U8fd8\U88ab\U6740\U624b\U4e4b\U738b\U65b9\U5929\U6536\U4e3a\U5f92\U5f1f\U2026\U2026";
 flag = 2;
 "is_vip" = 2;
 name = "\U5f88\U7eaf\U5f88\U66a7\U6627";
 "short_description" = "\U5c11\U5e74\U83b7\U795e\U773c\U955c\U6210\U6740\U624b";
 tags =     (
 "\U52a8\U4f5c",
 "\U604b\U7231"
 );
 */

@property(nonatomic,copy) NSString *author;//作者
@property(nonatomic,assign) long comicId;
@property(nonatomic,copy) NSString *conTag;//
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *a_description;//长描述
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) long flag;
@property(nonatomic,assign) long is_vip;
@property(nonatomic,copy) NSString *short_description;
@property(nonatomic,copy) NSArray *tags;//tag数组
@property(nonatomic,copy) NSString *subTitle;
@property(nonatomic,copy) NSString *comic_id;//
@property(nonatomic,copy) NSString *cornerInfo;//角度
@property(nonatomic,copy) NSString *wide_covier;

@end

NS_ASSUME_NONNULL_END
