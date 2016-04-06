//
//  mServiceAddressView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mGeneralSubView.h"
@interface mServiceAddressView : UIView

@property (strong, nonatomic) IBOutlet UILabel *mName;


@property (strong, nonatomic) IBOutlet UILabel *mAddress;


@property (strong, nonatomic) IBOutlet UIImageView *mHeader;


@property (strong, nonatomic) IBOutlet UIView *mPhoneView;


@property (strong, nonatomic) IBOutlet UIView *mTwo;


@property (strong, nonatomic) IBOutlet UIView *mTopupView;


@property (strong, nonatomic) IBOutlet UIView *mFour;

@property (strong, nonatomic) IBOutlet UIView *mFive;

/**
 *  图片1
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg1;
/**
 *  按钮1
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn1;

/**
 *  图片2
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg2;
/**
 *  按钮2
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn2;


/**
 *  图片3
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg3;
/**
 *  按钮3
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn3;


/**
 *  图片4
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg4;
/**
 *  按钮4
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn4;


/**
 *  图片5
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg5;
/**
 *  按钮5
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn5;






+ (mServiceAddressView *)shareView;

@end
