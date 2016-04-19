//
//  myOrderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderTableViewCell : UITableViewCell
#pragma mark---第一种cell样式
/**
 *  第一种cell样式
 *
 *  @param strong
 *  @param nonatomic
 *
 *  @return
 */
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mNum;
/**
 *  价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  支付按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mPayBtn;
/**
 *  评价按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mEvolutionBtn;


#pragma mark---第二种cell样式
/**
 *  第二种cell样式
 */
/**
 *  订单名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderName;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;
/**
 *  订单数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderNum;
/**
 *  订单图片
 */
@property (weak, nonatomic) IBOutlet UIView *mOrderImages;
/**
 *  订单价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderPrice;
/**
 *  左边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
/**
 *  右边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;


@end
