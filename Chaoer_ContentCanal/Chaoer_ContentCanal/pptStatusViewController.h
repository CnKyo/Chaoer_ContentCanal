//
//  pptStatusViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface pptStatusViewController : BaseVC
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBtn;

@end
