//
//  fixTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fixTableViewCell : UITableViewCell
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;


@property (weak, nonatomic) IBOutlet UIButton *mSelectBtn1;

@property (weak, nonatomic) IBOutlet UIButton *mSelectBtn2;

@property (weak, nonatomic) IBOutlet UIView *mBgk1;

@property (weak, nonatomic) IBOutlet UIView *mBgk2;

/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName2;
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg2;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice2;
/**
 *  详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail2;







@end
