//
//  PingJiaCell.h
//  XiCheBuyer
//
//  Created by 周大钦 on 15/7/17.
//  Copyright (c) 2015年 zdq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTempButton.h"

@interface PingJiaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UIImageView *mStarImg;
@property (weak, nonatomic) IBOutlet UILabel *mContent;
@property (weak, nonatomic) IBOutlet UILabel *mReply;
@property (weak, nonatomic) IBOutlet UIView *mReplyView;
@property (weak, nonatomic) IBOutlet UIView *mImgBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImgViewHeight;
@property (weak, nonatomic) IBOutlet MyTempButton *mReplyBT;
@property (weak, nonatomic) IBOutlet MyTempButton *mOrderBT;

@end
