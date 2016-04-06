//
//  senderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface senderTableViewCell : UITableViewCell

#pragma mark----第一种cell类型

/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UIButton *mContentBtn;
/**
 *  选择时间
 */
@property (weak, nonatomic) IBOutlet UIButton *mChoiceTime;
/**
 *  佣金
 */
@property (weak, nonatomic) IBOutlet UITextField *mMoneyTx;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UITextField *mPriceTx;
/**
 *  备注按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mNoteBtn;
/**
 *  发布按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mComfirBtn;
#pragma mark----第二种cell类型
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTiele;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mtime;

#pragma mark----第三种cell类型

/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
/**
 *  状态图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mStatusImg;
/**
 *  倒计时
 */
@property (weak, nonatomic) IBOutlet UILabel *mDownTime;
/**
 *  需求内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceTime;
/**
 *  服务佣金
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceMoney;
/**
 *  服务价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mServicePrice;
/**
 *  服务备注
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceNote;
/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;
/**
 *  完成按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mFinishBtn;


@end
