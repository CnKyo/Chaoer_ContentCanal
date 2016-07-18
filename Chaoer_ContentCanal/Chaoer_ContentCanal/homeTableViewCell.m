//
//  homeTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "homeTableViewCell.h"
#import "mGeneralSubView.h"
#import <RongIMKit/RongIMKit.h>

@implementation homeTableViewCell
{
    DCPicScrollView  *mScrollerView;
    mGeneralSubView *mSubView;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.contentView.mwidth, 150) WithImageUrls:arrtemp];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    __weak __typeof(self)weakSelf = self;
    
    [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
        [weakSelf.delegate cellWithBanerClicked:index];
        
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

- (void)setMSubArr:(NSArray *)mSubArr{
    for (UIView *vvv in self.contentView.subviews) {
        [vvv removeFromSuperview];
    }
    float x1 = 20;
    float y1 = 0;
    float btnWidth1 = DEVICE_Width/2-20;
    
    UIImage *imag11 = [UIImage imageNamed:@"qiuk_pay"];
    UIImage *imag21 = [UIImage imageNamed:@"canal_fix"];
    NSArray *imgArr11 = @[imag11,imag21];
    
    for (int i = 0; i<2; i++) {
        
        mSubView = [mGeneralSubView shareView];
        mSubView.frame =CGRectMake(x1, y1, btnWidth1, 110);
        mSubView.mImg.image = imgArr11[i];
        mSubView.mName.text = mSubArr[i];
        mSubView.mBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        mSubView.mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mSubView.mBtn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        
        mSubView.mBage.hidden = YES;
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mTwoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:mSubView];
        x1 += btnWidth1+20;
        
        if (x1 >= DEVICE_Width) {
            x1 = 0;
            y1 += 110;
        }
        
    }
    CGRect  mRect = self.contentView.frame;
    mRect.size.height = y1;
    self.contentView.frame = mRect;

}

- (void)setMMainArr:(NSArray *)mMainArr{

    for (UIView *vvv in self.contentView.subviews) {
        [vvv removeFromSuperview];
    }
    
    UIImage *imag1 = [UIImage imageNamed:@"community_life"];
    UIImage *imag2 = [UIImage imageNamed:@"person_service"];
    
    UIImage *imag3 = [UIImage imageNamed:@"movie_ticket"];
    
    UIImage *imag4 = [UIImage imageNamed:@"community_status"];
    
    UIImage *imag5 = [UIImage imageNamed:@"neiborhud"];
    
    UIImage *imag6 = [UIImage imageNamed:@"feedback_sorpport"];
    
    NSArray *imgArr = @[imag1,imag2,imag3,imag4,imag5,imag6];
        
    float x = 0;
    float y = 0;
    
    float btnWidth = DEVICE_Width/3;
    
    for (int i = 0; i<mMainArr.count; i++) {
        
        mSubView = [mGeneralSubView shareView];
        mSubView.frame = CGRectMake(x, y, btnWidth, 110);
        
        mSubView.layer.masksToBounds = YES;
        mSubView.layer.borderColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.91 alpha:1.00].CGColor;
        mSubView.layer.borderWidth = 0.5;
        
        
        mSubView.mImg.image = imgArr[i];
        mSubView.mName.text = mMainArr[i];
        
        mSubView.mBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        mSubView.mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mSubView.mBtn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        
        
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mSomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:mSubView];
        mSubView.mBage.hidden = YES;
        
        if (i == 4) {
            mSubView.mBage.hidden = NO;
            
            //收到消息,,,
            int allunread = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
            if( allunread > 0 )
            {//如果有 没有读的消息
                
                mSubView.mBage.text = [NSString stringWithFormat:@"%d",allunread];
            }
            else
            {
                mSubView.mBage.hidden = YES;
                
            }
            
        }
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    CGRect  mRect = self.contentView.frame;
    mRect.size.height = y;
    self.contentView.frame = mRect;

}

- (void)mSomeBtnAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(cellWithMainViewClicked:)]) {
        [self.delegate cellWithMainViewClicked:sender.tag];
    }

    
}

- (void)mTwoBtnAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(cellWithSubViewClicked:)]) {
        [self.delegate cellWithSubViewClicked:sender.tag];
    }
    
    
    
}
@end
