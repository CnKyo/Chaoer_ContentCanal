//
//  pptAddAddressViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface pptAddAddressViewController : BaseVC
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  先生按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mManBtn;
/**
 *  女士按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mWomenBtn;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddressLb;
/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  详情地址
 */
@property (weak, nonatomic) IBOutlet UITextField *mAddressDetailTx;
/**
 *  标签
 */
@property (weak, nonatomic) IBOutlet UIButton *mTagBtn;
/**
 *  保存  
 */
@property (weak, nonatomic) IBOutlet UIButton *mSaveBtn;

@end
