//
//  WKOrderHeadView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKOrderHeadView.h"

@implementation WKOrderHeadView


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (instancetype)headerWithTableView:(UITableView *)tableView{
    
    static NSString *mHeaderID = @"headerView";
    WKOrderHeadView *mHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:mHeaderID];
    
    if (!mHeaderView) {
        mHeaderView = [[WKOrderHeadView alloc] initWithReuseIdentifier:mHeaderID];
    }
    
    mHeaderView.contentView.backgroundColor = [UIColor whiteColor];
    
    return mHeaderView;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        /**
         *  设置cell可交互
         */
        self.contentView.userInteractionEnabled = YES;
        
        [self initView];
    }
    return self;
}
#pragma mark - 初始化view
- (void)initView{
    
    
    UIView *mLine1 = [UIView new];
    self.mLine1 = mLine1;
    mLine1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:mLine1];
    
    QHLButton *mBtn = [[QHLButton alloc] init];
    self.mSelectBtn = mBtn;
    
    //背景图
    [mBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    [mBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateSelected];
    //点击方法
    [mBtn addTarget:self action:@selector(mSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:mBtn];
    
    UIImageView *mImg = [[UIImageView alloc] init];
    self.mStoreImg = mImg;
    
    [self.contentView addSubview:mImg];
    
    UILabel *mName = [[UILabel alloc] init];
    self.mName = mName;
    
    [self.contentView addSubview:mName];
    
    UILabel *mStatus = [[UILabel alloc] init];
    mStatus.textAlignment = NSTextAlignmentRight;
    self.mStatus = mStatus;
    
    [self.contentView addSubview:mStatus];
    
    UIView *mLine2 = [UIView new];
    self.mLine2 = mLine2;
    mLine2.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.75];
    [self.contentView addSubview:mLine2];
    
    [mLine1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(@0);
        make.top.equalTo(self.contentView).offset(@0);
        make.height.offset(@10);
    }];
    
    [mBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(@10);
        make.top.equalTo(mLine1.bottom).offset(@15);
        make.height.width.offset(@20);
    }];
    
    [mImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mBtn.right).offset(@10);
        make.top.equalTo(mLine1.bottom).offset(@5);
        make.height.width.offset(@40);
        
    }];
    
    [mName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mImg.right).offset(@5);
        make.right.equalTo(mStatus.left).equalTo(@5);
        make.top.equalTo(mLine1.bottom).offset(@15);
        
    }];
    
    [mStatus makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mName.right).offset(@20);
        make.right.equalTo(self.contentView.right).offset(-5);
        make.top.equalTo(mLine1.bottom).offset(@15);
        
    }];
    
    [mLine2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(@0);
        make.top.equalTo(mImg.bottom).offset(@8);
        make.height.offset(@0.5);
    }];
    
}
#pragma mark - 选择按钮的点击事件
- (void)mSelectAction:(QHLButton *)sender{
    
    if ([self.WKHeaderViewDelegate respondsToSelector:@selector(headerWithView:andBtnSelected:andSection:)]) {
        [self.WKHeaderViewDelegate headerWithView:self
                                   andBtnSelected:sender.selected andSection:self.section];
    }
    
}
- (void)setShop:(GMyMarketOrderList *)shop{
    _shop = shop;
    
    self.mSelectBtn.selected = shop.selected;
    self.mSelectBtn.tag = shop.mShopId;
    self.mName.text = shop.mShopName;
    [self.mStoreImg sd_setImageWithURL:[NSURL URLWithString:shop.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];

}

@end
