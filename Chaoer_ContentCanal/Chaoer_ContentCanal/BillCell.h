//
//  BillCell.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mState;

@end
