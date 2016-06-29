//
//  communityOrderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityOrderTableViewCell : UITableViewCell
/**
 *  下单时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mNane;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mdobtn;



@end
