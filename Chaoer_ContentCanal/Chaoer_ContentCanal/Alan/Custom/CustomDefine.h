//
//  CustomDefine.h
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#ifndef CustomDefine_h
#define CustomDefine_h

#define RETCODE_SUCCESS  200

#define TABLE_PAGE_ROW              20  //每次页面调用20条数据

static NSString * const sAppKey_Cook     = @"104ef5c579850";
static NSString * const sAppKey_Weather     = @"104ef5c579850";
static NSString * const sAppKey_PostCode     = @"104ef5c579850";


const static int kTableAllDataNumber = -1;  //
const static int kTableFirstDataNumber = 0;  //
const static int kTableReloadDataNumber = 1;  //

const static int kNoneNumber = -1000;  //定义无用的初始值
const static int kSuccessNumber = 200;  //定义的成功返回值
const static int kFailNumber = 500;  //定义的失败返回值

static int const RESP_STATUS_YES                  = 200000;             //成功


#endif /* CustomDefine_h */
