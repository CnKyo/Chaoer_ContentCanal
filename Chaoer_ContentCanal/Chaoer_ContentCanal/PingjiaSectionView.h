//
//  PingjiaSectionView.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingjiaSectionView : UIView
@property (weak, nonatomic) IBOutlet UIView *BgView;
@property (weak, nonatomic) IBOutlet UIButton *mAllBT;
@property (weak, nonatomic) IBOutlet UIButton *mNoReplyBT;

+ (PingjiaSectionView *)shareView;

@end
