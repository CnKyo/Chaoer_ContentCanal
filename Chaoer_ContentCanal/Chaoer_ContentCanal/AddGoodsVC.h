//
//  AddGoodsVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/3.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface AddGoodsVC : BaseVC

@property (nonatomic,strong) void(^block)(BOOL flag);
//@property (nonatomic,strong) SGoods *mGoods;
@property (nonatomic,assign) int     mSelect; //1:上架 2:下架
//@property (nonatomic,strong) SGoodsCate *mCate;

@property (weak, nonatomic) IBOutlet UILabel *mLeftText;
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;
@property (weak, nonatomic) IBOutlet UIView *mLeftView;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (weak, nonatomic) IBOutlet UIImageView *mBgImg;
@property (weak, nonatomic) IBOutlet UIImageView *mPaizhao;
@property (weak, nonatomic) IBOutlet UILabel *mPzText;

@property (weak, nonatomic) IBOutlet UITextField *mGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *mTopLB;
@property (weak, nonatomic) IBOutlet UILabel *mBottomLB;
@property (weak, nonatomic) IBOutlet UITextField *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;
@property (weak, nonatomic) IBOutlet UITextField *mNum;

@property (weak, nonatomic) IBOutlet UIView *mMiddleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mMiddleViewHeight;
@property (weak, nonatomic) IBOutlet UIView *mPriceView;



- (IBAction)mRemarkClick:(id)sender;

- (IBAction)mAddClick:(id)sender;
- (IBAction)mBottomClick:(id)sender;

- (IBAction)mGoPhotoClick:(id)sender;
@end
