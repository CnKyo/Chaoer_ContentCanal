//
//  mCodeNameViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mCodeNameViewController : BaseVC

/**
 *  背景view
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  认证按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCodeBtn;
/**
 *  状态
 */
@property (strong, nonatomic) IBOutlet UILabel *mStatus;
/**
 *  个人信息
 */
@property (strong, nonatomic) IBOutlet UIButton *mInfoBtn;

@end
