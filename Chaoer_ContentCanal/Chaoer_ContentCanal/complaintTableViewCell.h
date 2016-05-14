//
//  complaintTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface complaintTableViewCell : UITableViewCell
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet IQTextView *mContent;
/**
 *  理由
 */
@property (weak, nonatomic) IBOutlet UILabel *mResonLb;
/**
 *  理由按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mResonBtn;
/**
 *  图片选择1
 */
@property (weak, nonatomic) IBOutlet UIButton *mPickImg1;
/**
 *  图片选择2
 */
@property (weak, nonatomic) IBOutlet UIButton *mPickImg2;
/**
 *  图片选择3
 */
@property (weak, nonatomic) IBOutlet UIButton *mPickImg3;

@end
