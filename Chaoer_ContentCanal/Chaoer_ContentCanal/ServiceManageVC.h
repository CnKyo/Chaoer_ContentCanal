//
//  ServiceManageVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceManageVC : BaseVC

@property (nonatomic,assign) int type;//1:商品 2:服务

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@end
