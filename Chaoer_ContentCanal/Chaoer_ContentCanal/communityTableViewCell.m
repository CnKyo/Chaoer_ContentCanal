//
//  communityTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityTableViewCell.h"
#import "mCommunityNavView.h"

#import "mActivitySubView.h"

#import "ZLSubProductView.h"
@implementation communityTableViewCell
{
    DCPicScrollView  *mScrollerView;
    
//    mCommunityNavView *mSubView;
    
    ZLSubProductView *mVView;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    
    self.mLogo.layer.masksToBounds = YES;
    self.mLogo.layer.cornerRadius = 3;
    
    
}

- (void)setMDataSourceArr:(NSArray *)mDataSourceArr{


    NSMutableArray *arrtemp = [NSMutableArray new];
    [arrtemp removeAllObjects];
    for (MBaner *banar in mDataSourceArr) {
        [arrtemp addObject:banar.mImgUrl];
    }
    
    [mScrollerView removeFromSuperview];
    
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.contentView.mwidth, 120) WithImageUrls:arrtemp];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    __weak __typeof(self)weakSelf = self;
    
    [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
        [weakSelf.delegate cellDidSelectedBanerIndex:index];
        
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    mScrollerView.AutoScrollDelay = 2.5f;
    //    picView.textColor = [UIColor redColor];
    
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        MLLog(@"%@",error);
    }];
    
    
    [self.contentView addSubview:mScrollerView];
    

}

- (void)setMScrollerSourceArr:(NSArray *)mScrollerSourceArr{

    for (UIView *view in self.mScrollerView.subviews) {
        [view removeFromSuperview];
    }
    
    int x = 5;
    int w = 100;
    int tag = 0;

    for (GHot *mHot in mScrollerSourceArr) {
        
        mVView = [ZLSubProductView initWithFrame:CGRectMake(x, 0, w, self.mScrollerView.mheight) andImg:mHot.mSmallImg andProductName:mHot.mGoodsName andOlPrice:mHot.mMarketPrice andNowPrice:mHot.mNowPrice];
        mVView.mBtn.tag = tag;
        [mVView.mBtn addTarget:self action:@selector(msBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mScrollerView addSubview:mVView];
        
        x+=w+5;
        tag++;
    }
    
    
    self.mScrollerView.contentSize = CGSizeMake(x, self.mScrollerView.mheight);
    
}

- (void)msBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithScrollerViewSelectedIndex:)]) {
        [self.delegate cellWithScrollerViewSelectedIndex:sender.tag];
    }
    
}


- (void)setMShopList:(GMarketList *)mShopList{
    
    
    self.mName.text = mShopList.mShopName;
    [self.mLogo sd_setImageWithURL:[NSURL URLWithString:mShopList.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    self.mDistance.layer.masksToBounds = YES;
    self.mDistance.layer.cornerRadius = 3;
    self.mDistance.layer.borderColor = [UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75].CGColor;
    self.mDistance.layer.borderWidth = 0.5;
    self.mDistance.text = [NSString stringWithFormat:@"%@m",mShopList.mDisTance];
    
    self.mWorkTime.attributedText = [Util WKLabelWithAttributString:@"营业时间:" andColorText:[NSString stringWithFormat:@"%@-%@  满:%.2f元 免配送费 ",mShopList.mOpenTime,mShopList.mCloseTime,mShopList.mFreePrice]];
    
    self.mNum.attributedText = [Util WKLabelWithAttributString:@"全部商品：" andColorText:[NSString stringWithFormat:@"%d  收藏数：%d ",mShopList.mGoodsNum,mShopList.mFocus]];
    
    self.mSenderPrice.attributedText = [Util WKLabelWithAttributString:@"配送费:" andColorText:[NSString stringWithFormat:@"%.2f元",mShopList.mDeliverPrice]];
   
    
    if (mShopList.mActivityArr.count <= 0) {
        self.mCellH =100;

    }else {
        
        CGFloat mYY = 0;
        
        for (UIView *vvv in self.mActivityView.subviews) {
            [vvv removeFromSuperview];
        }
        
        for (GCampain *mAct in mShopList.mActivityArr) {
            
            mActivitySubView *mActView = [mActivitySubView shareView];
            
            mActView.frame = CGRectMake(0, mYY, self.contentView.size.width, 30);
            
            mActView.mName.text = mAct.mName;
            mActView.mContent.text = mAct.mContent;
            [self.mActivityView addSubview:mActView];
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
            mYY += 32;
        }
        self.mCellH =100+ mYY;
    }
    
    


}

//- (IBAction)mCellDetailAction:(UIButton *)sender {
//
//    if ([self.delegate respondsToSelector:@selector(UITableViewWithCellDetailBtnAction:)]) {
//        [self.delegate UITableViewWithCellDetailBtnAction:self.mIndexPath];
//
//    }
//    
//}





@end
