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
    
    
    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodsDetail.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
      [self.mShopLogo sd_setImageWithURL:[NSURL URLWithString:mGoodsDetail.mShopImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.mShopName.text = mGoodsDetail.mShopName;
    self.mAllGoodsNum.text = [NSString stringWithFormat:@"所有商品：%d",mGoodsDetail.mGoodsNum];
    self.mFocusNum.text = [NSString stringWithFormat:@"关注数:%d",mGoodsDetail.mFocus];
    
    
    CGRect mActFrame = self.mShopDetailView.frame;
    
    
    if (mGoodsDetail.mCampainArr.count<=0) {
        
    }else{
        
        CGFloat xx = 0.0;
        CGFloat yy = self.mFocusNum.mbottom+3;
        
        for (GCampain *mAct in mGoodsDetail.mCampainArr) {
            
            mActView = [mActivitySubView shareView];
            mActView.frame = CGRectMake(xx, yy, self.contentView.mwidth, 30);
            mActView.mName.text = mAct.mName;
            mActView.mContent.text = mAct.mContent;
            [self.mShopDetailView addSubview:mActView];
            
            yy += 30;
            
            mActivityDetailH = yy;
            
        }
        mActFrame.size.height = mActivityDetailH-94;
        self.mShopDetailView.frame = mActFrame;
        
        self.mCellH = 248+mActivityDetailH-94;
        
    }
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
