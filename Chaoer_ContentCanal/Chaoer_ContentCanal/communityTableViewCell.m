//
//  communityTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityTableViewCell.h"
#import "mCommunityNavView.h"
@implementation communityTableViewCell
{
    DCPicScrollView  *mScrollerView;
    
    mCommunityNavView *mSubView;

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
    
    self.mActivity.layer.masksToBounds = YES;
    self.mActivity.layer.cornerRadius = 2;
    
    
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
    for (NSString *str in mScrollerSourceArr) {
        mSubView = [mCommunityNavView shaeScrollerSubView];
        mSubView.frame = CGRectMake(x, 0, w-5, self.mScrollerView.mheight);
        mSubView.mSName.text = str;
        mSubView.mSBtn.tag = tag;
        [mSubView.mSBtn addTarget:self action:@selector(msBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mScrollerView addSubview:mSubView];
        
        x+=w;
        tag++;
    }
    
    self.mScrollerView.contentSize = CGSizeMake(x, self.mScrollerView.mheight);
    
}

- (void)msBtnAction:(UIButton *)sender{

    [self.delegate cellWithScrollerViewSelectedIndex:sender.tag];
}

@end
