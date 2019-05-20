//
//  WLTX_App_HttpRequestUrlManagers.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/11.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#ifndef WLTX_App_HttpRequestUrlManagers_h
#define WLTX_App_HttpRequestUrlManagers_h


// 域名或者ip
#define WLTX_DomainOrIpUrl @"http://m.0201566.com/appapi/"

/*** 公共部分 ***/
#define Coomon_Release @"wdfb.php"                    // 发布 1物流供求 ，2 货源信息 ，5 物流招聘，3车源信息
#define Coomon_integrateQueryList(detailsId,page) [NSString stringWithFormat: @"zhcx_list.php?id=%@&page=%@",detailsId,page] // 综合列表

#define my_integrateQueryDetails(detailsId) [NSString stringWithFormat: @"zhcx_content.php?id=%@",detailsId] // 综合单页
//#define Common_citySearch(cityName) [NSString stringWithFormat:@"province_ts.php?name=%@",cityName] // 首页城市查询
#define Common_citySearch @"province_ts.php"                    // 首页城市查询

/*** 主页 ***/
#define Home_AdUrl @"banner.php"                    // 广告轮播图
#define Home_AdDetail @"banner_cont.php?id="        // 广告详情
#define Home_ShuttleRouteUrl @"zxzs.php"            // 专线展示
#define Home_IntegratedQueryListUrl @"zhcx.php"      // 综合查询
#define Home_Search @"list.php"                     // 知道起始地、目的地去查找
#define Home_Search1(qsd,mdd,page) [NSString stringWithFormat: @"list.php?qsd=%@&mdd=%@&page=%@",qsd,mdd,page] // 知道起始地、目的地、分页去查找

// 首页进来是 http://m.0201566.com/appapi/list.php?qsd=起始地&mdd=目的地&page=页数

/*** 专线查询 ***/
#define SpecialLine_ListUrl(page) [NSString stringWithFormat: @"list.php?page=%@",page] // 专线列表
#define SpecialLine_Search @"list.php"                          // 全局搜索
#define SpecialLine_Search1(q,page) [NSString stringWithFormat: @"list.php?q=%@&page=%@",q,page] // 知道关键字、分页去查找

// ⚠️get 请求不能进行拼接 会出现访问错误 。所以get请求需要用字典包装起来
//#define SpecialLine_Search(keyword,page) [NSString stringWithFormat: @"list.php?page=%@",page]
// http://m.0201566.com/appapi/list.php?q=关键词&page=页数

/*** 我的 ***/
#define my_AboutUsUrl @"about.php"                  // 关于我们
//#define my_changePassword @"user_xgmm.php"          // 修改密码


/** 注册、登录、忘记密码、修改密码 */
#define my_getVerificationCode @"yzm.php"           // 发送验证码
#define my_isRightVerificationCode @"is_yzm.php"    // 验证码核对
#define my_registerUserInfo @"zhuce.php"            // 注册，注册用户信息
#define my_login @"denglu.php"                      // 登录
#define my_getUserInfo @"my_grxx.php"              // 获取个人信息 get请求
#define my_changePasswrod @"user_xgmm.php"              // 修改密码


/** 我的 发布、共享、等等*/
#define my_getSumContributionValue @"my_gxz_sum.php"  // 我的贡献值总和
#define my_getCarList @"yfb_list_cl.php"  // 我发布的车辆
#define my_getpushInformationList @"yfb_list.php"  // 我发布的信息
#define my_getmy_grxx @"my_grxx.php"  // 个人信息
#define my_UpiconFile @"up.php"  // 上传头像图片
#define my_collection @"my_shoucang.php"  // 收藏
#define my_specialDetails(detailsId) [NSString stringWithFormat: @"content.php?id=%@",detailsId] // 专线详情
#define my_specialCollection(detailsId,phoneNumber) [NSString stringWithFormat: @"shoucang.php?id=%@&shouji=%@",detailsId,phoneNumber] // 物流线路收藏，取消收藏


#endif /* WLTX_App_HttpRequestUrlManagers_h */
