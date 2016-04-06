//
//  myOrderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderTableViewCell : UITableViewCell

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


@end
