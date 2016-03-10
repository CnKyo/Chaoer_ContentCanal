//
//  AddBankInfo.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/12/11.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankInfo : BaseVC

@property (nonatomic,strong) SShop *mShopInfo;
@property (nonatomic,strong) SWithDrawInfo *mDraw;
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mBankname;
@property (weak, nonatomic) IBOutlet UITextField *mBankNo;
@property (weak, nonatomic) IBOutlet UITextField *mCode;
@property (weak, nonatomic) IBOutlet UILabel *mDetailText;
@property (weak, nonatomic) IBOutlet UIButton *mCodeBT;
@property (weak, nonatomic) IBOutlet UIButton *mSubmitBT;


- (IBAction)mGetCodeClick:(id)sender;
- (IBAction)mSubmitClick:(id)sender;

@end
