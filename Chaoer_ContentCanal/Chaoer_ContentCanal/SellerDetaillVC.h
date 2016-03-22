//
//  SellerDetaillVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerDetaillVC : BaseVC

//@property (nonatomic,strong) SGoods *mGoods;
@property (nonatomic,assign) int     mType;
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet DYMainLabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mDianpu;
@property (weak, nonatomic) IBOutlet UILabel *mGuige;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mGuigeHeight;
@property (weak, nonatomic) IBOutlet UILabel *mServiceTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mServiceTimeHeight;
@property (weak, nonatomic) IBOutlet UILabel *mTypeName;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;
- (IBAction)mOutClick:(id)sender;

@end
