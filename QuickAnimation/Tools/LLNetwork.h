////
////   LLNetwork.h
////   NewLovelive
////
////   Created by zqc_mac on 16-11-1.
////   Copyright (c) 2016年 zqc_mac. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
//#import "AFNetworkActivityIndicatorManager.h"
//
///* 内网  */
//
////云服务
//////#define BASE_URL    @"http://client.bceapp.com/carmen"  // 2.0 外网
////#define Image_URL @"http://client.bceapp.com" //外网图片地址
////#define BASE_URL    @"http://180.76.118.31/carmen"  // 3.0 外网
//#pragma mark -- 新应用宏定义
//
//#define HOME_ID 70
//#define CATEGORY_ID 73
//#define MESSAGE_ID 72
//
//#define kBASEUrl                  @"http://app.u17.com/v3/appV3_3/ios/phone/"
//#define kComicList                @"list/commonComicList"//漫画列表
//#define kComicDetail_real         @"comic/detail_realtime"
//#define kComicDetail              @"comic/detail_static_new"//详情
//#define kComicRealTime            @"comic/detail_realtime"//realTime
//#define kComicCommentList         @"comment/list"//评论详情
//#define kChapterDetail            @"comic/chapterNew"//根据章节请求内容
//#define kBoutiqueList             @"comic/boutiqueListNew"
//#define kSortCateList             @"sort/mobileCateList"//分类列表
//#define kGuessLike                @"comic/guessLike"//猜你喜欢
//
//#define kHomeDataList             @"comic/boutiqueListNew"//首页内容网络请求
//
//#define kAPIKey                   @"fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"
//
//
//#define URL_REPORT_INFO           @"/report/init" //获取设备信息
//
//#define URL_USER_REG              @"/user/reg" //@"account=%@&password=%@",account,password
//#define URL_USER_LOGIN            @"/user/login"
//#define URL_USER_GET_INFO         @"/user/get"
//#define URL_USER_SET_INFO         @"/user/set"
//#define URL_USER_SET_AVATAR       @"/user/set_avatar"
//
//#define URL_CATE_INFO             @"/info/getcateandinfo"
//#define URL_NEWS_LIST             @"/info/get"  //信息列表，//
//#define URL_NEWS_VIEW             @"/info/view"  //查看信息计数
//#define URL_NEWS_USER             @"/info/my"   //用户发布的话题
//#define URL_NEWS_SENT             @"/info/set"  //用户发布话题
//#define URL_NEWS_LIKE             @"/info/like" //点赞或取消点赞
//#define URL_NEWS_USER_LIKE        @"/info/my_like" //查看用户喜欢的文章
//#define URL_NEWS_CATEGORY         @"/cate/get" //查询分类名称
//
//#define URL_COMMENT_SENT          @"/comment/set" //发布评论
//#define URL_COMMENT_GET           @"/comment/get" //获取文章评论
//#define URL_COMMENT_MY            @"/comment/my"  //获取用户评论
//
//
//@protocol NCNetworkCallBack <NSObject>
//
//- (void)successCallBack:(AFHTTPRequestOperation *) operation responseObject:(id)responseObject;
//- (void)failureCallBack:(AFHTTPRequestOperation *) operation error:(NSError *)error;
//
//@end
//
//@interface NCNetwork : NSObject
//
//@property(nonatomic,strong) NSMutableDictionary *parameter;//参数字典
//
//+ (AFHTTPRequestOperationManager *)getNetworkInstance;
//
////登录
//+ (AFHTTPRequestOperation *)getLoginWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////忘记密码/重置密码
//+ (AFHTTPRequestOperation *)putForgetAndResetPasswordWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//#pragma mark -- 获取漫画总的信息列表
//+ (AFHTTPRequestOperation *)getHotDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到漫画详情页信息
//+ (AFHTTPRequestOperation *)getComicDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到漫画评论详情页信息
//+ (AFHTTPRequestOperation *)getComicCommentDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到漫画RealTime信息
//+ (AFHTTPRequestOperation *)getComicRealTimeDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到漫画章节详情页信息
//+ (AFHTTPRequestOperation *)getComicChapterDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到发现页信息
//+ (AFHTTPRequestOperation *)getComicBoutiqueDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到推荐动漫的信息
//+ (AFHTTPRequestOperation *)getRecommendDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到分类动漫的信息
//+ (AFHTTPRequestOperation *)getClassDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到猜你喜欢的动漫的信息
//+ (AFHTTPRequestOperation *)getGuessLikeDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到首页页信息
//+ (AFHTTPRequestOperation *)getHomeDetailDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
//
//
//#pragma mark -- 注册用户信息
//+ (AFHTTPRequestOperation *)registerUserInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 获取到设备信息
//+ (AFHTTPRequestOperation *)reportAdviceInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
//
//
////上传图片
//+ (AFHTTPRequestOperation *)uploadImgWithimageArray:(NSArray *)array data:(NSData *)data delegate:(id)delegate;
//
//
////查询员工可见项目
//+ (AFHTTPRequestOperation *)getFindProjectsWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
////根据可见项目查询报销科目//
//+ (AFHTTPRequestOperation *)getWebContentWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////帮助与反馈
//+ (AFHTTPRequestOperation *)putOpinionsWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
////提交报销信息
//+ (AFHTTPRequestOperation *)putBillInfoWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////查询报销的详细信息
//+ (AFHTTPRequestOperation *)getInfoBillWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//+ (AFHTTPRequestOperation *)getInfoExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//+ (AFHTTPRequestOperation *)getInfoFinishExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////查询待审核列表
//+ (AFHTTPRequestOperation *)getWaitExpenseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
////驳回审核
//+ (AFHTTPRequestOperation *)putRepulseWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////个人费用汇总查询(左侧栏信息)
//+ (AFHTTPRequestOperation *)getCountWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
////报销条数查询(左侧栏信息)
//+ (AFHTTPRequestOperation *)getNumberWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 根据查询人及日期查询报工信息
//+ (AFHTTPRequestOperation *)getReportWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 上传报工信息
//+ (AFHTTPRequestOperation *)uploadReportWithimageArray:(NSArray *)array delegate:(id)delegate;
////下面这个上传报工信息方法为测试接口
//+ (void)uploadReportInfo:(NSMutableArray *)array success:(void(^)())success faith:(void(^)())faith;
//#pragma mark -- 左侧栏请求待审批报工个数接口
//+ (AFHTTPRequestOperation *)getReportApprovalCountWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 查询待我审批的信息接口
//+ (AFHTTPRequestOperation *)getWillApprovalReportDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 驳回一条报工信息的接口
//+ (AFHTTPRequestOperation *)postRejectReportDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 通过所有报工信息
//+ (AFHTTPRequestOperation *)postPassAllReportArray:(NSArray *)array delegate:(id)delegate;
//#pragma mark -- 启动休假申请，或被驳回后修改申请
//+ (AFHTTPRequestOperation *)putLeaveApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 启动出差申请，或被驳回后修改申请
//+ (AFHTTPRequestOperation *)putMissionApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 根据按公司或人查询出差申请信息
//+ (AFHTTPRequestOperation *)getMissionListDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 根据按公司和单号查询单条出差申请信息
//+ (AFHTTPRequestOperation *)getOneMissionDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 根据按公司和编号查询单个休假申请信息
//+ (AFHTTPRequestOperation *)getOneLeaveDataWithDateDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 分类查找待我审批的任务(不含报工) paramete 邮箱 是否审批过 类型
//+ (AFHTTPRequestOperation *)getTaskTypeDataWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//#pragma mark -- 驳回或通过 请假申请或者 出差申请，同一个接口
//+ (AFHTTPRequestOperation *)putLeaveMissionAgreeRefuseApplyWithDelegate:(id)delegate parameters:(NSDictionary *)parameters;
//
//
//
//@end
