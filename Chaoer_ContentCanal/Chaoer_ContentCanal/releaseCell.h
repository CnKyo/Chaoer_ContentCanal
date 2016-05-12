//
//  releaseCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface releaseCell : UITableViewCell

#pragma mark----cell第一种样式
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet IQTextView *mContentTx;
/**
 *  标签view
 */
@property (weak, nonatomic) IBOutlet UIView *mTagiew;
/**
 *  添加标签按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddTagBtn;

#pragma mark----cell第二种样式
/**
 *  价格lb
 */
@property (weak, nonatomic) IBOutlet UILabel *mPriceLb;
/**
 *  价格text
 */
@property (weak, nonatomic) IBOutlet UITextField *mPriceTx;
/**
 *  金额text
 */
@property (weak, nonatomic) IBOutlet UITextField *mMoneyTx;

#pragma mark----cell第三种样式
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UITextField *mTime;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextField *mNoteTX;

@end
