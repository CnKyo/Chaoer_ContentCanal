//
//  shopCarTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "shopCarTableViewCell.h"

@implementation shopCarTableViewCell

- (void)awakeFromNib {
    
    // 这三句代码可以代替- (void)setSelected:(BOOL)selected animated:(BOOL)animated
    UIView *view = [[UIView alloc] initWithFrame:self.multipleSelectionBackgroundView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = view;
    // 这个属性是编辑的时候最右边的accessory样式
    //    self.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        if (selected) {
            // 取消多选时cell成蓝色
            //            self.contentView.backgroundColor = [UIColor whiteColor];
            //            self.backgroundView.backgroundColor = [UIColor whiteColor];
            
        }else{
            
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (editing) {
        for (UIControl *control in self.subviews){
            if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
                for (UIView *v in control.subviews)
                {
                    if ([v isKindOfClass: [UIImageView class]]) {
                        UIImageView *img=(UIImageView *)v;
                        
                        img.image = [UIImage imageNamed:@"ppt_add_address_normal"];
                    }
                }
            }
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.mAddAndSubtract.layer.masksToBounds = YES;
    self.mAddAndSubtract.layer.cornerRadius = 4;
    self.mAddAndSubtract.layer.borderColor = [UIColor redColor].CGColor;
    self.mAddAndSubtract.layer.borderWidth = 0.5;
    
    //    self.selected = NO;
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"ppt_add_address_selected"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"ppt_add_address_normal"];
                    }
                }
            }
        }
    }

    
}
@end
