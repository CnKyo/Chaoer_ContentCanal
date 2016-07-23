//
//  mFeedCompanyViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "IQTextView.h"
@interface mFeedCompanyViewController : BaseVC


/**
 *  原因
 */
@property (strong, nonatomic) IBOutlet IQTextView *mReason;

/**
 *  发送
 */
@property (strong, nonatomic) IBOutlet UIButton *mSendBtn;
/**
 *  1是投诉2是商品备注
 */
@property (assign,nonatomic) int mType;
@property (nonatomic,strong) void(^block)(NSString *mName);

@end
