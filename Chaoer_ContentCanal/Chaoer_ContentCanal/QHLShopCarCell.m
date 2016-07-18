//
//  QHLShopCarCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "QHLShopCarCell.h"

@implementation QHLShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{

    self.mOpratorView.layer.masksToBounds = self.mJianBtn.layer.masksToBounds = self.mAddBtn.layer.masksToBounds = YES;
    self.mOpratorView.layer.cornerRadius = 5;
    self.mOpratorView.layer.borderColor = [UIColor redColor].CGColor;
    self.mOpratorView.layer.borderWidth = 0.5;
    
    
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    
    QHLShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[QHLShopCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell可交互
        self.contentView.userInteractionEnabled = YES;
        

        return self;
    }
    return self;
}

- (IBAction)mSelectAction:(QHLButton *)sender {
    
    if ([self.cellDelegate respondsToSelector:@selector(cell:selBtnDidClickToChangeAllSelBtn:andIndexPath:)]) {
        [self.cellDelegate cell:self selBtnDidClickToChangeAllSelBtn:sender.selected andIndexPath:self.indexPath];

    }
    
    
    
    
}

- (IBAction)mJianAction:(QHLButton *)sender {
    
    if ([self.cellDelegate respondsToSelector:@selector(cell:JianBtnDidClicked:andIndexPath:)]) {
        [self.cellDelegate cell:self JianBtnDidClicked:sender.selected andIndexPath:self.indexPath];
    }
    
}

- (IBAction)mAddAction:(QHLButton *)sender {

    if ([self.cellDelegate respondsToSelector:@selector(cell:AddBtnDidClicked:andIndexPath:)]) {
        [self.cellDelegate cell:self AddBtnDidClicked:sender.selected andIndexPath:self.indexPath];
    }
    
}

- (void)setMGoods:(QHLGoods *)mGoods{

    _mGoods = mGoods;
    
    //设置cell中的子控件数据
    self.mSelectedBtn.selected = mGoods.selected;
    self.mSelectedBtn.tag = [mGoods.tag intValue];
    self.mContent.text = mGoods.introduction;
    self.mPrice.text = [NSString stringWithFormat:@"￥:%d",[mGoods.price intValue]];
    self.mName.text = mGoods.name;

}


@end
