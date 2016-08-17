//
//  DryCleanServerTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"

@interface DryCleanServerTableViewCell : UITableViewCell
@property(strong, nonatomic) UIImageView*       thumbImgView;
@property(strong, nonatomic) UILabel*           nameLable;
@property(strong, nonatomic) UILabel*           priceLable;

@property(strong, nonatomic) UIButton*          jianBtn;
@property(strong, nonatomic) UILabel*           countLable;
@property(strong, nonatomic) UIButton*          addBtn;
@end