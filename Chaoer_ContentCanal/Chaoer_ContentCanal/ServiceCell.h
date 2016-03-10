//
//  ServiceCell.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UIButton *mCheck;
@property (weak, nonatomic) IBOutlet UIButton *mEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLeftConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mRightConst;

@end
