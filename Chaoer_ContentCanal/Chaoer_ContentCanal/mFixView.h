//
//  mFixView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFixView : UIView

@property (strong, nonatomic) IBOutlet UIButton *mYuyueBtn;


@property (strong, nonatomic) IBOutlet UIButton *mPayBtn;


@property (strong, nonatomic) IBOutlet UITextView *mTxView;

@property (strong, nonatomic) IBOutlet UIButton *mLeftBtn;

@property (strong, nonatomic) IBOutlet UIButton *mRightBtn;

@property (strong, nonatomic) IBOutlet UILabel *mAddress;

@property (strong, nonatomic) IBOutlet UILabel *mPhone;

@property (strong, nonatomic) IBOutlet UILabel *mTime;


+ (mFixView *)shareView;


@end
