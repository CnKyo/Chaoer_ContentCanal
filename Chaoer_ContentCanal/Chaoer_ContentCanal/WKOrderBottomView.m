//
//  WKOrderBottomView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKOrderBottomView.h"

@implementation WKOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.6;
        
        [self initView];
    }
    
    return self;
}
/**
 *  构造界面
 */
- (void)initView{
    QHLButton *allSelBtn = [[QHLButton alloc] init];
    
    //背景图
    [allSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    [allSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateSelected];
    //点击方法
    [allSelBtn addTarget:self action:@selector(allSelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.mAllSelBtn = allSelBtn;
    
    [self addSubview:allSelBtn];
    
    UILabel *allSelLbl = [[UILabel alloc] init];
    
    //字体大小
    allSelLbl.font = [UIFont systemFontOfSize:15];
    //内容
    allSelLbl.text = @"全选";
    //颜色
    allSelLbl.textColor = [UIColor blackColor];
    
    [self addSubview:allSelLbl];
    self.mAllSelectedLb = allSelLbl;


    UILabel *totalLbl = [[UILabel alloc] init];
    totalLbl.textAlignment = NSTextAlignmentCenter;
    //字体大小
    totalLbl.font = [UIFont systemFontOfSize:14];
    //内容
    totalLbl.text = [NSString stringWithFormat:@"结算:￥0"];
    //字体颜色
    totalLbl.textColor = [UIColor redColor];
    [self addSubview:totalLbl];
    self.mTotalLbl = totalLbl;
    
    QHLButton *checkOutBtn = [[QHLButton alloc] init];
    //背景色
    [checkOutBtn setBackgroundColor:[UIColor redColor]];
    //设置字体
    [checkOutBtn setTitle:[NSString stringWithFormat:@"去支付(0)"] forState:UIControlStateNormal];
    
    [self addSubview:checkOutBtn];
    self.mGoPayBtn = checkOutBtn;
    //点击事件
    [checkOutBtn addTarget:self action:@selector(checkOutBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.mAllSelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(@10);
        make.top.equalTo(self).offset(@20);
        make.width.height.offset(@20);
    }];
    
    [self.mAllSelectedLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mAllSelBtn.right).offset(@5);
        make.right.equalTo(self.mTotalLbl.left).offset(-5);
        make.top.equalTo(self).offset(@22);
//        make.bottom.equalTo(self).offset(@20);
        make.width.offset(@50);
    }];
    
    [self.mTotalLbl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mAllSelectedLb.right).offset(@5);
        make.right.equalTo(self.mGoPayBtn.left).offset(-5);
        make.top.equalTo(self).offset(@22);
//        make.bottom.equalTo(self).offset(@20);
    }];

    [self.mGoPayBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mTotalLbl.right).offset(@5);
        make.right.equalTo(self).offset(@0);
        make.top.equalTo(self).offset(@0);
        make.bottom.equalTo(self).offset(@0);
        make.width.offset(@150);
    }];

}
#pragma mark - 全选按钮的点击事件
- (void)allSelBtnDidClick:(QHLButton *)allSelBtn {

    if ([self.bottomDelegate respondsToSelector:@selector(allSelectedWithView:didSelected:)]) {
        [self.bottomDelegate allSelectedWithView:self didSelected:allSelBtn.selected];
    }
    
}
#pragma mark - 计算点击事件
- (void)checkOutBtnDidClick:(QHLButton *)checkOutBtn {
    NSLog(@"%s",__func__);
    [self.bottomDelegate mGoPayAction];
}
- (void)setMNum:(NSInteger)mNum{

    _mNum = mNum;
    //设置结算按钮文字
    [self.mGoPayBtn setTitle:[NSString stringWithFormat:@"去支付(%ld)",mNum] forState:UIControlStateNormal];
    
}
- (void)setMMoney:(NSInteger)mMoney{
    _mMoney = mMoney;
    self.mTotalLbl.text = [NSString stringWithFormat:@"结算:￥%ld",mMoney];
    
}
- (void)setBtnSelected:(BOOL)btnSelected{

    _btnSelected = btnSelected;
    
    self.mAllSelBtn.selected = btnSelected;
}
@end
