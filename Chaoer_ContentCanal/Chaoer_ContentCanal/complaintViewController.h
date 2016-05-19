//
//  complaintViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface complaintViewController : BaseVC
/**
 *  跑腿类型 1是商品买送 2是事情办理 3是送东西
 */
@property (nonatomic,assign) int mType;
@property (strong,nonatomic) GPPTOrder *mOrder;
@end
