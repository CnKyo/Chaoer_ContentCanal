//
//  moreCell.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/18.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreCell : UITableViewCell
///图片
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
///标题
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
///是否有消息
@property (weak, nonatomic) IBOutlet UIImageView *mPoint;

///时间
@property (weak, nonatomic) IBOutlet UILabel *mTime;
///订单编号
@property (weak, nonatomic) IBOutlet UILabel *mOrderID;
///钱
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@end
