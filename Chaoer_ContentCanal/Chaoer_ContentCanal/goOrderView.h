//
//  goOrderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface goOrderView : UIView
/**
 *  服务地址
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  服务地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceAddress;
/**
 *  服务时间
 */
@property (weak, nonatomic) IBOutlet UIButton *mServiceTimeBtn;
/**
 *  服务人员
 */
@property (weak, nonatomic) IBOutlet UIButton *mChoiceServiceBtn;
/**
 *  服务图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImag;
/**
 *  服务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceName;
/**
 *  服务价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mServicePrice;
/**
 *  服务详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
/**
 *  服务押金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  上传图片
 */
@property (weak, nonatomic) IBOutlet UIButton *mUploadImgBtn;
/**
 *  上传视频
 */
@property (weak, nonatomic) IBOutlet UIButton *mUploadVideoBtn;

@property (weak, nonatomic) IBOutlet IQTextView *mNoteTx;


/**
 *  初始化方法
 *
 *  @return view
 */
+ (goOrderView *)shareView;

@end
