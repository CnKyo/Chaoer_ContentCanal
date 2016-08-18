//
//  mFoodRateTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodRateTableViewCell.h"
#import "RatingBar.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation mFoodRateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMRateNum:(NSInteger)mRateNum{

    for (UIView *vvv in self.mRateVie.subviews) {
        [vvv removeFromSuperview];
    }
    
    RatingBar *mRate = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0,self.mRateVie.mwidth, self.mRateVie.mheight)];
    mRate.starNumber = mRateNum;
    [self.mRateVie addSubview:mRate];
    
}


- (void)setMImgArr:(NSArray *)mImgArr{
    
    if (mImgArr.count<=0) {
        self.mImgsViewH.constant = 0;
    }
    
    for (UIImageView *vvv in self.mRateImgsArr.subviews) {
        [vvv removeFromSuperview];
    }
    
    float mXX = 0;
    
    for (int i = 0; i<mImgArr.count; i++) {
        
        
        if (i >= 4) {
            return;
        }else{
            
            UIImageView *iii = [UIImageView new];
            iii.userInteractionEnabled = YES;
            iii.tag = i;
            iii.frame = CGRectMake(mXX, 0, 50, 50);
            //            [iii sd_setImageWithURL:[NSURL URLWithString:mImgArr[i]] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
            iii.image = mImgArr[i];

            if (mXX >= self.mRateImgsArr.mwidth ) {
                return;
            }else{
             
                
                [self.mRateImgsArr addSubview:iii];
                
                
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgAction:)];
            [iii addGestureRecognizer:tap];

            mXX += 70;
            
            
        }
   
    }
    
}

- (void)imgAction:(UIGestureRecognizer *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithImgBrowserClickedAndTag:andSubViews:)]) {
        [self.delegate cellWithImgBrowserClickedAndTag:sender.view.tag andSubViews:self.mRateImgsArr];
    }
    
    
   
}

@end
