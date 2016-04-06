//
//  WebVC.h
//  YiZanService
//
//  Created by zzl on 15/3/29.
//  Copyright (c) 2015年 zywl. All rights reserved.
//

#import "BaseVC.h"

@interface WebVC : BaseVC

@property (nonatomic,strong) NSString*  mName;
@property (nonatomic,strong) NSString*  mUrl;

@property (nonatomic,assign)    BOOL    mBWebStack;


/*
   {"address":"","mapPos":"39.92286165667622,116.39264456494679|39.92286165667622,116.4043580170844|39.91387850311673,116.4043580170844|39.91387850311673,116.39264456494679"}
 
 */
@property (nonatomic,strong)  void(^itblock)(NSString* addr,NSString* mappoints);

//编辑商品,返回HTML字符串,,,设置itgoodsblock
@property (nonatomic,strong)  void(^itgoodsblock)(NSString* content);

@end
