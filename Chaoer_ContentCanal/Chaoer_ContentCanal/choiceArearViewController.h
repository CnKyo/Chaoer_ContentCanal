//
//  choiceArearViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface choiceArearViewController : BaseVC

@property (nonatomic,strong) void(^block)(NSString *block ,NSString *mId);
/**
 *  省市id
 */
@property (nonatomic,strong) NSString *mProvinceId;
/**
 *  区县id
 */
@property (nonatomic,strong) NSString *mArearId;
/**
 *  城市id
 */
@property (nonatomic,strong) NSString *mCityId;

@end
