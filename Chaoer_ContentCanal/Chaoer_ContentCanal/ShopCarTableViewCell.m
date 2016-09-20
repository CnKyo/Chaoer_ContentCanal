//
//  ShopCarTableViewCell.m
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "ShopCarTableViewCell.h"
#import "CountView.h"

@interface ShopCarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (strong, nonatomic) IBOutlet UIView *countview;
@property (weak, nonatomic) IBOutlet UIImageView *mShopImg;

@property (strong, nonatomic) CountView *mCountview;


@end
@implementation ShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIView *vvv in self.countview.subviews) {
        [vvv removeFromSuperview];
    }
    
    self.mCountview = [[CountView alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
    
    __weak typeof(self)MySelf = self;
    self.mCountview.CountBlock = ^(NSInteger num){
        if (MySelf.delegate && [self.delegate respondsToSelector:@selector(changeTheShopCount:count:)]) {
            [MySelf.delegate changeTheShopCount:MySelf count:num];
        }
    };
    
    [self.countview addSubview:self.mCountview];
}

-(void)setModel:(GShopCarGoods *)model{
    _model = model;
    self.shopTitle.text = _model.mGoodsName;
    self.priceLable.text = [NSString stringWithFormat:@"￥%.2f", _model.mTotlePrice];
    self.mCountview.count =  [[NSString stringWithFormat:@"%d",_model.mQuantity] intValue];
    
    [self.mShopImg sd_setImageWithURL:[NSURL URLWithString:model.mGoodsImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.mContent.text = [NSString stringWithFormat:@"数量：%d%@",model.mQuantity,model.mSpecifications];

    
    if (_model.mSelected) {
        [self.leftBtn setImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateNormal];
    }else{
        [self.leftBtn setImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    }
}

- (IBAction)leftBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedWichLeftBtn:)]) {
        [self.delegate clickedWichLeftBtn:self];
    }
}
@end
