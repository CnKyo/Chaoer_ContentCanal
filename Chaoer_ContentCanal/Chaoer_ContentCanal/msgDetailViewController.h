//
//  msgDetailViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface msgDetailViewController : BaseVC
/**
 *  背景view
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mMsgTitle;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;

@end
