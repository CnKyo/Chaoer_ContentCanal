//
//  BillHeadView.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UIButton *mczBt;

+ (BillHeadView *)shareView;

@end
