//
//  RecordCell.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/2.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mStatus;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@end
