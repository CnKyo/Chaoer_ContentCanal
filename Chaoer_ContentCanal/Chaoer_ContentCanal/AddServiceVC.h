//
//  AddServiceVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface AddServiceVC : BaseVC


@property (nonatomic,strong) void(^block)(BOOL flag);

@property (nonatomic,strong) SGoods *mGoods;
@property (nonatomic,assign) int     mSelect; //1:上架 2:下架
@property (nonatomic,strong) SGoodsCate *mCate;

@property (weak, nonatomic) IBOutlet UIImageView *mBgImg;
@property (weak, nonatomic) IBOutlet UIImageView *mPaiZhao;
@property (weak, nonatomic) IBOutlet UILabel *mPzText;

@property (weak, nonatomic) IBOutlet UITextField *mPrice;
@property (weak, nonatomic) IBOutlet UITextField *mServiceName;

@property (weak, nonatomic) IBOutlet UITextField *mMinTime;
@property (weak, nonatomic) IBOutlet UILabel *mSellerName;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;
@property (weak, nonatomic) IBOutlet UIView *mXjView;
@property (weak, nonatomic) IBOutlet UIView *mYlView;
@property (weak, nonatomic) IBOutlet UIView *mDelView;
@property (weak, nonatomic) IBOutlet UILabel *mTopLB;
@property (weak, nonatomic) IBOutlet UILabel *mBottomLB;
@property (weak, nonatomic) IBOutlet UILabel *mShangjia;
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;

- (IBAction)mRemarkClick:(id)sender;

- (IBAction)mPhotoClick:(id)sender;

- (IBAction)mBottomClick:(id)sender;

- (IBAction)GoSellerClick:(id)sender;

@end
