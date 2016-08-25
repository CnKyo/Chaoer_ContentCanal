//
//  valletTCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "valletTCell.h"

@implementation valletTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMObj:(GScroe *)mObj{

    self.mTime.text = mObj.mAddTime;
    
    int mType = mObj.mType;
    
    if (mType == 2) {
        self.mStatus.text = @"充值";
        self.mScore.text = [NSString stringWithFormat:@"%d积分",mObj.mScore];
        
    }else{
        self.mStatus.text = @"支付";
        self.mScore.text = [NSString stringWithFormat:@"%d积分",mObj.mScore];
        
    }
    self.mtitle.text = mObj.mDescribe;
    
    
    self.mCellH = 33 + [Util labelText:mObj.mDescribe fontSize:14 labelWidth:self.mtitle.mwidth];
    
    

}
- (void)setMTransfer:(GTransferHistory *)mTransfer{
    self.mTime.text = mTransfer.mDescription;
    self.mtitle.text = [NSString stringWithFormat:@"编号:%@",mTransfer.mOrderCode];
    self.mScore.text = [NSString stringWithFormat:@"%@",mTransfer.mPhone];
    self.mStatus.text = [NSString stringWithFormat:@"%@",mTransfer.mAddTime];
    self.mCellH = 33 + [Util labelText:mTransfer.mDescription fontSize:14 labelWidth:self.mtitle.mwidth];

}
@end
