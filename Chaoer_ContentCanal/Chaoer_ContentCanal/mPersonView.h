//
//  mPersonView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mPersonView : UIView
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mHeaderImg;
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  身份
 */
@property (strong, nonatomic) IBOutlet UILabel *mJob;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;

/**
 *  积分
 */
@property (strong, nonatomic) IBOutlet WPHotspotLabel *mScore;



/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet WPHotspotLabel *mBalance;

@property (strong, nonatomic) IBOutlet UIButton *mHeaderBtn;


/**
 *  初始化方法
 *
 *  @return view
 */
+ (mPersonView *)shareView;

/**
 *  消息按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mMessageBtn;
/**
 *  气泡
 */
@property (strong, nonatomic) IBOutlet UILabel *mBadg;
/**
 *  初始化右边的view
 *
 *  @return 　view
 */
+ (mPersonView *)shareRightView;

@end
