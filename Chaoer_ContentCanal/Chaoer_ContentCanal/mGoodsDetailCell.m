//
//  mGoodsDetailCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailCell.h"

#import "mActivitySubView.h"
@implementation mGoodsDetailCell
{
    
    
    CGFloat mActivityDetailH;
    
    mActivitySubView *mActView;

}

- (void)layoutSubviews{

    [super layoutSubviews];

//    [self initData];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMGoodsDetail:(SGoodsDetail *)mGoodsDetail{
    
    NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};

    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodsDetail.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
      [self.mShopLogo sd_setImageWithURL:[NSURL URLWithString:mGoodsDetail.mShopImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.mShopName.text = mGoodsDetail.mShopName;
    
    
    self.mAllGoodsNum.attributedText = [[NSString stringWithFormat:@"所有商品：<color>%d</color>",mGoodsDetail.mGoodsNum] attributedStringWithStyleBook:mStyle];
    self.mFocusNum.attributedText = [[NSString stringWithFormat:@"关注数:<color>%d</color>",mGoodsDetail.mFocus] attributedStringWithStyleBook:mStyle];
    
    
    CGRect mActFrame = self.mShopDetailView.frame;
    
    
    
        
    CGFloat xx = 0.0;
    CGFloat yy = self.mFocusNum.mbottom+3;
    
    for (GCampain *mAct in mGoodsDetail.mCampainArr) {
        
        mActView = [mActivitySubView shareView];
        mActView.frame = CGRectMake(xx, yy, self.contentView.mwidth, 30);
        mActView.mName.text = mAct.mName;
        mActView.mContent.text = mAct.mContent;
        [self.mShopDetailView addSubview:mActView];
        if ([mAct.mCode isEqualToString:@"A"]) {
            mActView.mName.backgroundColor = [UIColor colorWithRed:0.91 green:0.13 blue:0.14 alpha:0.75];
        }else if ([mAct.mCode isEqualToString:@"B"]){
            mActView.mName.backgroundColor = [UIColor colorWithRed:0.82 green:0.47 blue:0.62 alpha:0.75];
            
        }else if ([mAct.mCode isEqualToString:@"C"]){
            mActView.mName.backgroundColor = [UIColor colorWithRed:0.52 green:0.76 blue:0.22 alpha:0.75];
            
        }else if ([mAct.mCode isEqualToString:@"D"]){
            mActView.mName.backgroundColor = [UIColor colorWithRed:0.16 green:0.53 blue:1.00 alpha:0.75];
            
        }else{
            mActView.mName.backgroundColor = M_CO;
            
        }
        
        yy += 30;
        
        mActivityDetailH = yy;
        
    }
    mActFrame.size.height = mActivityDetailH-94;
    self.mShopDetailView.frame = mActFrame;
    
    self.mCellH = 248+mActivityDetailH-94;
    
    
    self.mGoodsName.text = mGoodsDetail.mGoodsName;
    self.mGoodsContent.text = mGoodsDetail.mGoodsDscribe;
    
    self.mOldPrice.text = [NSString stringWithFormat:@"原价:¥%.2f元",mGoodsDetail.mMarketPrice];
    
    self.mNoewPrice.text = [NSString stringWithFormat:@"现价:¥%.2f元",mGoodsDetail.mGoodsPrice];
    
    self.mAddress.text = mGoodsDetail.mAddress;
    self.mSalesNum.text = [NSString stringWithFormat:@"%d",mGoodsDetail.mShopSalesNum];
    self.mSendPrice.text = [NSString stringWithFormat:@"¥%.2f元",mGoodsDetail.mDelivePrice];
    _mGoodsDetailH = 150+[Util labelText:mGoodsDetail.mGoodsDscribe fontSize:14 labelWidth:self.mGoodsContent.mwidth]-20;
}

@end
