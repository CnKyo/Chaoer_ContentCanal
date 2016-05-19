//
//  evolutionViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface evolutionViewController : BaseVC
/**
 *  跑腿类型 1是商品买送 2是事情办理 3是送东西
 */
@property (nonatomic,assign) int mType;
@property (strong,nonatomic) GPPTOrder *mOrder;
@property (strong,nonatomic)NSString *mLng;

@property (strong,nonatomic)NSString *mLat;
@end
