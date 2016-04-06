//
//  senderSubView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface senderSubView : UIView

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  联系他
 */
@property (weak, nonatomic) IBOutlet UIButton *mConnectBtn;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  佣金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UILabel *mNote;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBtn;


/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (senderSubView *)shareView;

@end
