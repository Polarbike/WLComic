//
//  MHNetworking.h
//  QuickAnimation
//
//  Created by Weilian on 16/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//


#define kBASEUrl                  @"http://app.u17.com/v3/appV3_3/ios/phone/"
#define kComicList                @"list/commonComicList"//漫画列表
#define kComicDetail_real         @"comic/detail_realtime"
#define kComicDetail              @"comic/detail_static_new"//详情
#define kComicRealTime            @"comic/detail_realtime"//realTime
#define kComicCommentList         @"comment/list"//评论详情
#define kChapterDetail            @"comic/chapterNew"//根据章节请求内容
#define kBoutiqueList             @"comic/boutiqueListNew"
#define kSortCateList             @"sort/mobileCateList"//分类列表
#define kGuessLike                @"comic/guessLike"//猜你喜欢

#define kHomeDataList             @"comic/boutiqueListNew"//首页内容网络请求

#define kAPIKey                   @"fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"


#import <Foundation/Foundation.h>
@class PPNetworkHelper;
@class AFHTTPSessionManager;

//typedef void(^successBlock)(id);
//typedef void(^failureBlock)(id);

NS_ASSUME_NONNULL_BEGIN

@interface MHNetworking : NSObject

//@property(nonatomic,copy) successBlock success;
//
//@property(nonatomic,copy) successBlock failure;
//
//@property(nonatomic,copy) dispatch_block_t cache;
//
//@property(nonatomic,copy) void(^testBlock)(NSString *string , NSString *name);
+ (instancetype)sharedInstance;

#pragma mark -- 获取到首页更多按钮动漫的信息
+ (void)getHotDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
//#pragma mark -- 获取到首页更多按钮动漫的信息
//+ (void)getHotDataWithParameters:(NSDictionary *)parameters success:(void(^)(id))success failure:(void(^)(id))failure;
#pragma mark -- 获取到漫画详情页信息
+ (void)getComicDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到漫画RealTime信息
+ (void)getComicRealTimeDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到漫画评论详情页信息
+ (void)getComicCommentDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到漫画章节详情页信息
+ (void)getComicChapterDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到发现页信息
+ (void)getComicBoutiqueDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到推荐动漫的信息
+ (void)getRecommendDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到分类动漫的信息
+ (void)getClassParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到猜你喜欢的动漫的信息
+ (void)getGuessLikeDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;
#pragma mark -- 获取到首页信息
+ (void)getHomeDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;

@end

NS_ASSUME_NONNULL_END
