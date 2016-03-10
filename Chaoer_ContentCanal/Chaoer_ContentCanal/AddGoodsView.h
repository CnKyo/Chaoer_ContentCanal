//
//  AddGoodsView.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGoodsView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mDelBT;
@property (weak, nonatomic) IBOutlet UITextField *mNorm;
@property (weak, nonatomic) IBOutlet UITextField *mPrice;
@property (weak, nonatomic) IBOutlet UITextField *mNum;
@property (nonatomic,assign)    int        mNormId;

+ (AddGoodsView *)shareView;

@end
