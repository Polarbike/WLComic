//
////  LLNetwork.m
////  NewLovelive
////
////  Created by zqc_mac on 15-5-28.
////  Copyright (c) 2015年 zqc_mac. All rights reserved.
////
//
//#import "LLNetwork.h"
//#import <CoreFoundation/CoreFoundation.h>
//
//
//@implementation NCNetwork
//
//static AFHTTPRequestOperationManager *manager = nil;
////static NSMutableArray *requestOperationArray;
//
//+ (AFHTTPRequestOperationManager *)getNetworkInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[AFHTTPRequestOperationManager alloc] init];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.requestSerializer.timeoutInterval = 30;
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//
//
//    });
//
//    [manager.securityPolicy setAllowInvalidCertificates:YES];
//
//    return manager;
//}
//
//+ (AFHTTPRequestOperation *)requestWithMethod:(NSString *)method url:(NSString *)url  Parameters:(NSDictionary *)parameters delegate:(id)delegate
//{
//
//    NSMutableDictionary *tmpParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
//
//    AFHTTPRequestOperationManager *requestOperationManager = [NCNetwork getNetworkInstance];
//
//    requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    AFHTTPRequestOperation *requestOperation;
//    if([method isEqualToString:@"GET"])
//    {
//
////        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
////        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
////        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json", nil];
//
//        requestOperation = [requestOperationManager GET:url parameters:tmpParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                            NSError *err;
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                                    options:NSJSONReadingMutableContainers
//                                                                      error:&err];
//                if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)])
//                {
//                    [delegate successCallBack:operation responseObject:dic];
//                }
//
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//            NSInteger code = [operation.response statusCode];
//            if(code == 401)
//            {
//
//            }
//            else
//            {
//                NSDictionary *user = error.userInfo;
//                NSError *erro = [user objectForKey:@"NSUnderlyingError"];
//                NSDictionary *d = erro.userInfo;
//                NSData *data = [d objectForKey:@"com.alamofire.serialization.response.error.data"];
//                NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)])
//                {
//
//                    [delegate failureCallBack:operation error:error];
//                }
//            }
//        }];
//    }
//    else if([method isEqualToString:@"POST"])
//
//    {
//
////        AFHTTPRequestOperationManager *requestOperationManager = [NCNetwork getNetworkInstance];
////        AFHTTPRequestOperation *requestOperation;
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:url]];
//        [request setHTTPMethod:@"POST"];
//
////        [request setValue:APIKEY forKey:@"apikey"];
//        manager.responseSerializer= [AFJSONResponseSerializer serializer];
//        NSString *contentType = [NSString stringWithFormat:@"application/json;"];
//        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//
//        NSDictionary *bodyDic = [tmpParameters objectForKey:@"body"];
//
//        if(bodyDic)
//        {
//            NSError *error;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDic
//                                                               options:0
//                                                                 error:&error];
//
////            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
////            NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
////                                                                          NULL,
////                                                                          (__bridge CFStringRef)jsonStr,
////                                                                          NULL,
////                                                                          CFSTR("!*’();:@&=+$,/?%#[]"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
////            NSData *data = [encodedString dataUsingEncoding:NSUTF8StringEncoding];
//
//            [request setHTTPBody:jsonData];
//        }
//
//        requestOperation = [requestOperationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)])
//            {
//                [delegate successCallBack:operation responseObject:responseObject];
//            }
//
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//
//            NSInteger code = [operation.response statusCode];
//            if(code == 401)
//            {
////                [g_App showAlertWithQuit:@"已下线"];
//
//            }
//            else
//            {
//                NSDictionary *user = error.userInfo;
//                NSError *erro = [user objectForKey:@"NSUnderlyingError"];
//                NSDictionary *d = erro.userInfo;
//                NSData *data = [d objectForKey:@"com.alamofire.serialization.response.error.data"];
//                NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//
//                if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)])
//                {
//
//                    [delegate failureCallBack:operation error:error];
//                }
//            }
//
//
//        }];
//        [requestOperation start];
//
//    }
//    else if([method isEqualToString:@"DELETE"])
//    {
//
//        requestOperation = [requestOperationManager DELETE:url parameters:tmpParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)])
//            {
//                [delegate successCallBack:operation responseObject:responseObject];
//            }
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//
//            NSInteger code = [operation.response statusCode];
//            if(code == 401)
//            {
////                [g_App showAlertWithQuit:@"已下线"];
//
//            }
//            else
//            {
//                NSDictionary *user = error.userInfo;
//                NSError *erro = [user objectForKey:@"NSUnderlyingError"];
//                NSDictionary *d = erro.userInfo;
//                NSData *data = [d objectForKey:@"com.alamofire.serialization.response.error.data"];
//                NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//
//                if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)])
//                {
//
//                    [delegate failureCallBack:operation error:error];
//                }
//            }
//        }];
//    }
//    else if([method isEqualToString:@"PUT"])
//    {
//        AFHTTPRequestOperationManager *requestOperationManager = [NCNetwork getNetworkInstance];
//
//        requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
//        requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
//
//        // 设置请求头
//        [requestOperationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:url]];
//
//        [request setHTTPMethod:@"PUT"];
//        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        NSDictionary *bodyDic = [tmpParameters objectForKey:@"body"];
//
//
//        if(bodyDic)
//        {
//            NSError *error;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDic
//                                                               options:NSJSONWritingPrettyPrinted
//                                                                 error:&error];
//
//            [request setHTTPBody:jsonData];
//
//
//        }else{
//
////          这里应该写 是PUT上传，参数是query类型而非body体的情况下应该做的事情，但是没找到有效的方法暂时空着
//
//        }
//        requestOperation = [requestOperationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)])
//            {
//                [delegate successCallBack:operation responseObject:responseObject];
//            }
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//            NSInteger code = [operation.response statusCode];
//            if(code == 401)
//            {
////                [g_App showAlertWithQuit:@"已下线"];
//
//            }
//            else
//            {
//                NSDictionary *user = error.userInfo;
//                NSError *erro = [user objectForKey:@"NSUnderlyingError"];
//                NSDictionary *d = erro.userInfo;
//                NSData *data = [d objectForKey:@"com.alamofire.serialization.response.error.data"];
//                NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//
//                if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)])
//                {
//
//                    [delegate failureCallBack:operation error:error];
//                }
//            }
//
//
//        }];
//        [requestOperation start];
//
//    }
//    return requestOperation;
//}
//
//
//+ (NSMutableURLRequest *)postRequestWithURL:(NSString *)url content:(NSString *)text
//{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
//
//    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    return request;
//}
//
//#pragma mark -- 用户登录信息
//+ (AFHTTPRequestOperation *)getLoginWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//    NSString *method = @"GET";
//
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_USER_LOGIN];
//       AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//
//
//
//#pragma mark -- 获取到首页更多按钮动漫的信息
//+ (AFHTTPRequestOperation *)getHotDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到漫画详情页信息
//+ (AFHTTPRequestOperation *)getComicDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicDetail];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到漫画RealTime信息
//+ (AFHTTPRequestOperation *)getComicRealTimeDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicRealTime];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到漫画评论详情页信息
//+ (AFHTTPRequestOperation *)getComicCommentDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicCommentList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到漫画章节详情页信息
//+ (AFHTTPRequestOperation *)getComicChapterDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kChapterDetail];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到发现页信息
//+ (AFHTTPRequestOperation *)getComicBoutiqueDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kBoutiqueList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到推荐动漫的信息
//+ (AFHTTPRequestOperation *)getRecommendDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kComicList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到分类动漫的信息
//+ (AFHTTPRequestOperation *)getClassDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kSortCateList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到猜你喜欢的动漫的信息
//+ (AFHTTPRequestOperation *)getGuessLikeDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters {
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kGuessLike];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 获取到首页信息
//+ (AFHTTPRequestOperation *)getHomeDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters{
//
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, kBoutiqueList];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//
//
//
//
//
//
//#pragma mark -- 上传图片接口
//+ (AFHTTPRequestOperation *)uploadImgWithimageArray:(NSArray *)array data:(NSData *)data delegate:(id)delegate;
//{
////    LoveLiveUtil *util = [LoveLiveUtil getInstance];
//    NSString *path = @"/FeeInfo/uploadImage";
////    NSString *urlStr = [NSString stringWithFormat:@"%@%@?operator=%@&companyNo=%@",BASE_URL,path, util.userInfo.employeeEmail, util.userInfo.companyNo];
//    NSString *urlStr = @"";
//    AFHTTPRequestOperationManager *currentManager = [NCNetwork getNetworkInstance];
//    AFHTTPRequestOperation *requestOperation = [currentManager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
//
//        for (int i = 0; i<array.count; i++) {
//
//            NSDate *date = [NSDate date];
//            NSDateFormatter  *dateFormatter =[[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"YYYYMMddHHmmsss"];
//            NSString *nameStr = [dateFormatter stringFromDate:date];
//
//            NSData *imageData = [array objectAtIndex:i];
//
//            [formData appendPartWithFileData:imageData name:@"images"fileName:[NSString stringWithFormat:@"%@_%d.jpg",nameStr,i] mimeType:@"image/jpeg"];
//
//        }
//
//    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:&err];
//        if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)]) {
//            [delegate successCallBack:operation responseObject:dic];
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)]) {
//            [delegate failureCallBack:operation error:error];
//        }
//    }];
//
//
//    return requestOperation;
//
//}
//#pragma mark -- 获取设备信息   /report/init
//+ (AFHTTPRequestOperation *)reportAdviceInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_REPORT_INFO];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//#pragma mark -- 获取用户信息
//+ (AFHTTPRequestOperation *)getFindProjectsWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_USER_GET_INFO];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 注册用户信息
//+ (AFHTTPRequestOperation *)registerUserInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//    NSString *method = @"GET";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_USER_GET_INFO];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//}
////#pragma mark -- 设置用户信息
////+ (AFHTTPRequestOperation *)putForgetAndResetPasswordWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
////{
////    NSString *method = @"PUT";
////    NSString *path = @"/EmployeeInfo/passReset";
////
////    NSString * tempStremail = parameters[@"employeeEmail"];
////    NSString * tempStrnew = parameters[@"employeePassNew"];
////    NSString * tempStrold = parameters[@"employeePassOld"];
////
////    NSString * temppath;
////
////    //重置密码
////    if (tempStrnew.length >0) {
////
////
////        temppath = [NSString stringWithFormat:@"%@?employeeEmail=%@&employeePassNew=%@&employeePassOld=%@",path,tempStremail,tempStrnew,tempStrold];
////
////    }else{
////
////        //忘记密码
////        tempStremail = [NSString stringWithFormat:@"employeeEmail=%@",tempStremail];
////        temppath = [NSString stringWithFormat:@"%@?%@",path,tempStremail];
////
////    }
////
////    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, temppath];
////    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:nil delegate:delegate];
////    return requestOperation;
////
////}
//
//
////帮助与反馈
//+ (AFHTTPRequestOperation *)putOpinionsWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//
//    NSString *method = @"PUT";
//    NSString *path = @"/Feedback/save";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//
//}
//
//#pragma mark -- new app 获取请求的内容信息
//+ (AFHTTPRequestOperation *)getWebContentWithDelegate:(id)delegate parameters:(NSDictionary *)parameters
//{
//
//    NSString *method = @"GET";
////    NSString *path = @"/ProjectInfo/findProjectSubjectRels";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_NEWS_LIST];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
////提交报销信息
//+ (AFHTTPRequestOperation *)putBillInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//    NSString *method = @"PUT";
//    NSString *path = @"/FeeInfo/save";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//}
//
////查询报销的详细信息
//+ (AFHTTPRequestOperation *)getInfoBillWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//    NSString *method = @"GET";
//    NSString *path = @"/FeeInfo/findOne";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
////报销列表请求数据
//+ (AFHTTPRequestOperation *)getInfoExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters {
//
//    NSString *method = @"GET";
//    NSString *path = @"/FeeInfo/findByPerson";
////    companyNo=&employeeEmail=&status=&paymentDetailNo=
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
////已完成报销的数据请求
//+ (AFHTTPRequestOperation *)getInfoFinishExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters {
//
//    NSString *method = @"GET";
//    NSString *path = @"/FeeInfo/findComplete";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//
//
//
////驳回审核
//+ (AFHTTPRequestOperation *)putRepulseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//    NSString *method = @"PUT";
//    NSString *path = @"/workflow/approval";
//
//
//    NSString * tempStremail = parameters[@"employeeEmail"];
//    NSString * temcompanyNo = parameters[@"companyNo"];
//    NSString * temptaskId = parameters[@"taskId"];
//    NSString * temppass = parameters[@"pass"];
//    NSString * temprejectReason = parameters[@"rejectReason"];
//
//
//    NSString *urlString = [NSString stringWithFormat:@"%@%@?companyNo=%@&employeeEmail=%@&taskId=%@&pass=%@&rejectReason=%@", kBASEUrl, path,temcompanyNo,tempStremail,temptaskId,temppass,[temprejectReason stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
//
////    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
////查询待审核列表
///*
// 在更新出差和报工后，不再使用这个接口查询报销
// */
//+ (AFHTTPRequestOperation *)getWaitExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//
//    NSString *method = @"GET";
//    NSString *path = @"/workflow/findTasks";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
////个人费用汇总查询(左侧栏信息)
//+ (AFHTTPRequestOperation *)getCountWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//    NSString *method = @"GET";
//    NSString *path = @"/app/leftMenu";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//
////报销条数查询(左侧栏信息)
//+ (AFHTTPRequestOperation *)getNumberWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//    NSString *method = @"GET";
//    NSString *path = @"/FeeInfo/findStatusSum";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 根据提交人和日期查询报工信息
//+ (AFHTTPRequestOperation *)getReportWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//{
//
//    NSString *method = @"GET";
//    NSString *path = @"/ReportJobInfo/findBySubmitterAndCompanyNoAndTimeSpan";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 将报工信息提交服务器
//+ (AFHTTPRequestOperation *)uploadReportWithimageArray:(NSArray *)array delegate:(id)delegate {
//
//    NSString *path = @"/ReportJobInfo/save";
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//
//    AFHTTPRequestOperationManager *currentManager = [NCNetwork getNetworkInstance];
//    currentManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    currentManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    AFHTTPRequestOperation *requestOperation = [currentManager POST:urlStr parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
////        NSError *err;
////        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
////                                                            options:NSJSONReadingMutableContainers
////                                                              error:&err];
//        if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)]) {
//            [delegate successCallBack:operation responseObject:responseObject];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //
//        if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)]) {
//            [delegate failureCallBack:operation error:error];
//        }
//    }];
//
//    return requestOperation;
//
//}
//
//+ (void)uploadReportInfo:(NSMutableArray *)array success:(void(^)())success faith:(void(^)())faith {
//
//    NSString *path = @"/ReportJobInfo/save";
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager POST:urlStr parameters:array success:^(NSURLSessionDataTask *task, id responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        faith(error);
//    }];
//
//}
////#pragma mark -- 根据提交人和日期查询报工信息
////+ (AFHTTPRequestOperation *)getReportApprovalCountWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
////{
////
////    NSString *method = @"GET";
////    NSString *path = @"/ReportJobInfo/findAggrInfoByApproval";
////    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
////    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
////    return requestOperation;
////
////}
//
//#pragma mark -- 设置用户信息
//+ (AFHTTPRequestOperation *)postRejectReportDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters
//{
//
//    NSString *method = @"POST";
//    NSString *path = @"/ReportJobInfo/rejectJobInfo";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, URL_USER_SET_INFO];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:parameters forKey:@"body"];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:dic delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 通过所有报工信息
////+ (AFHTTPRequestOperation *)postPassAllReportDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters
////{
////
////    NSString *method = @"POST";
////    NSString *path = @"/ReportJobInfo/passJobInfo";
////    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
////    NSDictionary *dic = [NSDictionary dictionaryWithObject:parameters forKey:@"body"];
////    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:dic delegate:delegate];
////    return requestOperation;
////
////}
//+ (AFHTTPRequestOperation *)postPassAllReportArray:(NSArray *)array delegate:(id)delegate {
//
//    NSString *path = @"/ReportJobInfo/passJobInfo";
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//
//    AFHTTPRequestOperationManager *currentManager = [NCNetwork getNetworkInstance];
//    currentManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    currentManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    AFHTTPRequestOperation *requestOperation = [currentManager POST:urlStr parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
//        //        NSError *err;
//        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
//        //                                                            options:NSJSONReadingMutableContainers
//        //                                                              error:&err];
//        if(delegate && [delegate respondsToSelector:@selector(successCallBack:responseObject:)]) {
//            [delegate successCallBack:operation responseObject:responseObject];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //
//        if(delegate && [delegate respondsToSelector:@selector(failureCallBack:error:)]) {
//            [delegate failureCallBack:operation error:error];
//        }
//    }];
//
//    return requestOperation;
//
//}
//#pragma mark -- 启动休假申请，或被驳回后修改申请
//+ (AFHTTPRequestOperation *)putLeaveApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//
//    NSString *method = @"PUT";
//    NSString *path = @"/LeaveRequest/save";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 启动出差申请，或被驳回后修改申请
//+ (AFHTTPRequestOperation *)putMissionApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//
//    NSString *method = @"PUT";
//    NSString *path = @"/BusinessTrip/save";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//#pragma mark -- 根据按公司或人查询出差申请信息
//+ (AFHTTPRequestOperation *)getMissionListDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters
//{
//
//    NSString *method = @"GET";
//    NSString *path = @"/BusinessTrip/findByPerson";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//}
//#pragma mark -- 根据按公司和单号查询单条出差申请信息
//+ (AFHTTPRequestOperation *)getDeviceDateDelegate:(id)delegate parameters:(NSDictionary *)parameters
//{
//
//    NSString *method = @"GET";
//    NSString *path = @"/BusinessTrip/findOne";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBASEUrl, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//}
//
//
//#pragma mark -- 驳回请假申请
//+ (AFHTTPRequestOperation *)putLeaveMissionAgreeRefuseApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;{
//
//
//    NSString *method = @"PUT";
//    NSString *path = @"/workflow/approval";
//
//    NSString * tempStremail = parameters[@"employeeEmail"];
//    NSString * temcompanyNo = parameters[@"companyNo"];
//    NSString * temptaskId = parameters[@"taskId"];
//    NSString * temppass = parameters[@"pass"];
//    NSString * temprejectReason = parameters[@"rejectReason"];
//
//
//    NSString *urlString = [NSString stringWithFormat:@"%@%@?companyNo=%@&employeeEmail=%@&taskId=%@&pass=%@&rejectReason=%@", kBASEUrl, path,temcompanyNo,tempStremail,temptaskId,temppass,[temprejectReason stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
//
////    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
//    AFHTTPRequestOperation *requestOperation = [NCNetwork requestWithMethod:method url:urlString Parameters:parameters delegate:delegate];
//    return requestOperation;
//
//}
//
//- (NSMutableDictionary *)parameter {
//
//    if (!_parameter) {
//
//        _parameter = [[NSMutableDictionary alloc] init];
//        //获取当前时间戳
//        double date = [[NSDate date] timeIntervalSince1970];
//        NSNumber *number = [NSNumber numberWithDouble:date];
//        [_parameter setObject:number forKey:@"time"];
//        //设备uuid
//        NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
//        [_parameter setObject:uuid forKey:@"device_id"];
//        //apikey
//        [_parameter setObject:kAPIKey forKey:@"key"];
//        //设备model
//        NSString *model = [UIDevice currentDevice].model;
//        [_parameter setObject:model forKey:@"model"];
//        //target
//        [_parameter setObject:@"U17_4.0" forKey:@"target"];
//        //version
//        NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//        [_parameter setObject:version forKey:@"version"];
//        /*
//         "time": Int32(Date().timeIntervalSince1970),
//         "device_id": UIDevice.current.identifierForVendor!.uuidString,
//         "key": UApiKey.key,
//         "model": UIDevice.current.modelName,
//         "target": "U17_4.0",
//         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
//         */
//    }
//    return _parameter;
//}
//
//
//@end
