//
//  paotuiViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface paotuiViewController : BaseVC

/**
 *  判断类型
 */
@property (assign,nonatomic) int    mType;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  账号
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  押金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mbtn;

@end
