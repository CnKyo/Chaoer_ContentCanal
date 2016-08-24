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
    
    DCPicScrollView  *mScrollerView;


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

- (void)setMImgArr:(NSArray *)mImgArr{
    
    for (UIView *vvv in self.contentView.subviews) {
        [vvv removeFromSuperview];
    }
    
    if (mImgArr.count<=1) {
        
        UIImageView *miii = [UIImageView new];
        miii.frame = CGRectMake(0, 0, self.contentView.mwidth, 300);
        [miii sd_setImageWithURL:[NSURL URLWithString:mImgArr[0]] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
        [self.contentView addSubview:miii];
        
    }else{
    
        //显示顺序和数组顺序一致
        //设置图片url数组,和滚动视图位置
        mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.contentView.mwidth, 300) WithImageUrls:mImgArr];
        
        //显示顺序和数组顺序一致
        //设置标题显示文本数组
        
        //占位图片,你可以在下载图片失败处修改占位图片
        mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
        
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        __weak __typeof(self)weakSelf = self;
        
        [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
            
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
    
    
}
-(void)setMGoodsDetail:(SGoodsDetail *)mGoodsDetail{
    
    self.mActivTag.layer.masksToBounds = YES;
    self.mActivTag.layer.cornerRadius = 8;
    
    NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};

    
    
    self.mFocus.attributedText = [[NSString stringWithFormat:@"关注数:<color>%d</color>",mGoodsDetail.mFocus] attributedStringWithStyleBook:mStyle];
    
    
    
    self.mGoodsName.text = mGoodsDetail.mGoodsName;
    
    self.mOldPrice.text = [NSString stringWithFormat:@"原价:¥%.2f元",mGoodsDetail.mMarketPrice];
    
    self.mNoewPrice.text = [NSString stringWithFormat:@"现价:¥%.2f元",mGoodsDetail.mGoodsPrice];
    
    self.mAddress.text = mGoodsDetail.mAddress;
    self.mSalesNum.text = [NSString stringWithFormat:@"%d",mGoodsDetail.mShopSalesNum];
    self.mSendPrice.text = [NSString stringWithFormat:@"¥%.2f元",mGoodsDetail.mDelivePrice];
    
    self.mWorkTime.text = [NSString stringWithFormat:@"营业时间:%@-%@",mGoodsDetail.mOpenTime,mGoodsDetail.mCloseTime];
    
    self.mActTitle.text = @"活动:";

    if (mGoodsDetail.mCampainArr.count <= 1) {
        
        if (mGoodsDetail.mCampainArr.count == 0 || mGoodsDetail.mCampainArr.count == 1) {
            self.mActTitle.hidden = NO;
            self.mCheckMore.hidden = YES;
            self.mActivTag.text = @"无";
            self.mActivContent.text = @"暂无优惠活动";

        }
        for (int i=0; i<mGoodsDetail.mCampainArr.count; i++) {
            
            GCampain *mCampain = mGoodsDetail.mCampainArr[i];
            self.mActivTag.text = mCampain.mName;
            self.mActivContent.text = mCampain.mContent;
            if ([mCampain.mCode isEqualToString:@"A"]) {
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.91 green:0.13 blue:0.14 alpha:0.75];
            }else if ([mCampain.mCode isEqualToString:@"B"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.82 green:0.47 blue:0.62 alpha:0.75];
                
            }else if ([mCampain.mCode isEqualToString:@"C"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.52 green:0.76 blue:0.22 alpha:0.75];
                
            }else if ([mCampain.mCode isEqualToString:@"D"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.16 green:0.53 blue:1.00 alpha:0.75];
                
            }else{
                mActView.mName.backgroundColor = M_CO;
                
            }
            
        }
    
    }else{
        self.mCheckMore.hidden = NO;
        self.mActivTag.text = @"无";
        self.mActivContent.text = @"暂无优惠活动";
    }
    
    
    
}

- (IBAction)mCheck:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cellWithCheckMoreActivityBtn)]) {
        [self.delegate cellWithCheckMoreActivityBtn];
    }
}




@end
