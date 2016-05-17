//
//  pptChartsTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptChartsTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  结单数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderNum;
/**
 *  等级
 */
@property (weak, nonatomic) IBOutlet UILabel *mLevel;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  标签view
 */
@property (weak, nonatomic) IBOutlet UIView *mTagView;

@property (nonatomic,strong) NSArray *mTagArr;


@end
