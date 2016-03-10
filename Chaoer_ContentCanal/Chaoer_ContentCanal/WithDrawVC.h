//
//  WithDrawVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithDrawVC : BaseVC


@property (nonatomic,strong) void(^itblock)(BOOL flag);

@property (nonatomic,strong) SShop *mShop;
@property (nonatomic,strong) SWithDrawInfo *mDrawInfo;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UITextField *mPriceTF;

@property (weak, nonatomic) IBOutlet UIButton *mTiXian;

@property (weak, nonatomic) IBOutlet UILabel *mBank;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;

- (IBAction)AllClick:(id)sender;
- (IBAction)mTiXianClick:(id)sender;

@end
