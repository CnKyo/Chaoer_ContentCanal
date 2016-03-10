//
//  PingJiaHeadView.h
//  CommunityBuyer
//
//  Created by 周大钦 on 15/10/10.
//  Copyright © 2015年 zdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingJiaHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mFen;

@property (weak, nonatomic) IBOutlet UIImageView *mXing;

+ (PingJiaHeadView *)shareView;

@end
