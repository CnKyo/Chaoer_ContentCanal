//
//  pptTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptTableViewCell.h"
#import "mGeneralSubView.h"

@implementation pptTableViewCell
{
    DCPicScrollView  *mScrollerView;
    mGeneralSubView *mSubView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    self.mHeader.layer.masksToBounds = YES;
    self.mHeader.layer.cornerRadius = 3;
    
    
    self.mDoneBtn.layer.masksToBounds = YES;
    self.mDoneBtn.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMBanerArr:(NSArray *)mBanerArr{
    for (UIView *vvv in self.mBanerView.subviews) {
        [vvv removeFromSuperview];
    }

    NSMutableArray *arrtemp = [NSMutableArray new];
    [arrtemp removeAllObjects];
    for (MBaner *banar in mBanerArr) {
        [arrtemp addObject:banar.mImgUrl];
    }
    
    [mScrollerView removeFromSuperview];
    
    if (arrtemp.count != 0) {
        //显示顺序和数组顺序一致
        //设置图片url数组,和滚动视图位置
        mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.contentView.mwidth, self.mBanerView.mheight) WithImageUrls:arrtemp];
        
        //显示顺序和数组顺序一致
        //设置标题显示文本数组
        
        //占位图片,你可以在下载图片失败处修改占位图片
        mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
        
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        __weak __typeof(self)weakSelf = self;
        
        [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
            printf("第%zd张图片\n",index);
            if ([weakSelf.delegate respondsToSelector:@selector(WKCellWithBanerClicked:)]) {
                [weakSelf.delegate WKCellWithBanerClicked:index];
            }
            
            
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
        
        
        [self.mBanerView addSubview:mScrollerView];

    }
    
}

- (void)setMMainBtnArr:(NSArray *)mMainBtnArr{

    
    for (UIView *view in self.mMainBtnView.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    NSArray *mII = @[[UIImage imageNamed:@"ppt_seniority"],[UIImage imageNamed:@"ppt_release"],[UIImage imageNamed:@"ppt_history"],[UIImage imageNamed:@"ppt_my"]];
    
    CGFloat mmW = self.mMainBtnView.mwidth/4;
    
    for (int i = 0; i<mMainBtnArr.count; i++) {
        
        mSubView = [mGeneralSubView shareSubView];
        
        mSubView.mName.text = mMainBtnArr[i];
        mSubView.mImg.image = mII[i];
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mMainBtnView addSubview:mSubView];
        
        
        [mSubView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mMainBtnView).offset(@5);
            make.left.equalTo(self.mMainBtnView).offset(i*mmW);
            make.width.height.offset(mmW);
            
        }];
        
    }

    
}

- (void)mBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(WKCellWithMainBtnClicked:)]) {
            [self.delegate WKCellWithMainBtnClicked:sender.tag];
    }

}

- (void)setMOrder:(GPPTOrder *)mOrder{
    if (mOrder.mProcessStatus == 0) {
        [self.mDoneBtn setTitle:@"取消订单" forState:0];
        
        self.mDoneBtn.backgroundColor = [UIColor lightGrayColor];
        self.mDoneBtn.enabled = NO;
    }else{
        if ([mUserInfo backNowUser].mUserId == [mOrder.mUserId intValue]) {
            
            
            [self.mDoneBtn setTitle:@"取消订单" forState:0];
            self.mDoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            self.mDoneBtn.backgroundColor = M_CO;
            self.mDoneBtn.tag = 10;
            
        }else{
            
            if ([mUserInfo backNowUser].mIs_leg != 5) {
                [self.mDoneBtn setTitle:@"接单" forState:0];
                
                self.mDoneBtn.backgroundColor = [UIColor lightGrayColor];
                self.mDoneBtn.enabled = NO;
            }else{
                [self.mDoneBtn setTitle:@"接单" forState:0];
                self.mDoneBtn.backgroundColor = M_CO;
                self.mDoneBtn.enabled = YES;
                self.mDoneBtn.tag = 20;
            }
        }
        
    }
    
    
    [self.mHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mOrder.mPortrait]] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    if (mOrder.mType == 0) {
        
        self.mTitle.text = mOrder.mContext;
        
        self.mMoney.text = [NSString stringWithFormat:@"%@分钟/%@m",mOrder.mAlias,mOrder.mDistance];
    }else if (mOrder.mType == 3) {
        self.mTitle.text = mOrder.mContext;
        self.mMoney.text = [NSString stringWithFormat:@"%@元/%@m",mOrder.mAlias,mOrder.mDistance];
        
    }else if(mOrder.mType ==2){
        self.mTitle.text = mOrder.mContext;
        self.mMoney.text = [NSString stringWithFormat:@"%@分钟/%@m",mOrder.mAlias,mOrder.mDistance];
        
    }else{
        self.mTitle.text = mOrder.mContext;
        self.mMoney.text = [NSString stringWithFormat:@"%@分钟/%@m",mOrder.mAlias,mOrder.mDistance];
    }
    self.mDoneBtn.mOrder = mOrder;
    
    
    
    self.mDistance.text = [NSString stringWithFormat:@"酬金：%@元",mOrder.mLegworkMoney];

}

- (IBAction)mDoneAction:(mOrderButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKCellWithDoneBtnAction:)]) {
        [self.delegate WKCellWithDoneBtnAction:self.mIndexPath];
    }
    
    
}



@end
