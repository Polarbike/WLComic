//
//  MHNetworking.m
//  QuickAnimation
//
//  Created by Weilian on 16/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MHNetworking.h"
#import "PPNetworkHelper.h"
#import "AFHTTPSessionManager.h"


static MHNetworking *_instance = nil;
@implementation MHNetworking


+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[MHNetworking alloc] init];
    });
    
    return _instance;
}


#pragma mark -- 获取到首页更多按钮动漫的信息
+ (void)getHotDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
    
}
#pragma mark -- 获取到漫画详情页信息
+ (void)getComicDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicDetail];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
    
}
#pragma mark -- 获取到漫画RealTime信息
+ (void)getComicRealTimeDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicRealTime];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}
#pragma mark -- 获取到漫画评论详情页信息
+ (void)getComicCommentDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicCommentList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
    
}
#pragma mark -- 获取到漫画章节详情页信息
+ (void)getComicChapterDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure{
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kChapterDetail];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}
#pragma mark -- 获取到发现页信息
+ (void)getComicBoutiqueDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure{
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kBoutiqueList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}
#pragma mark -- 获取到推荐动漫的信息
+ (void)getRecommendDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure;{
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}
#pragma mark -- 获取到分类动漫的信息
+ (void)getClassParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kSortCateList];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
    
}
#pragma mark -- 获取到猜你喜欢的动漫的信息
+ (void)getGuessLikeDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kGuessLike];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}
#pragma mark -- 获取到首页信息
+ (void)getHomeDetailDataWithParameters:(NSDictionary *)parameters success:(void(^)(id result))success failure:(void(^)(id error))failure {
    
//    NSString *method = @"GET";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kBoutiqueList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}



@end
