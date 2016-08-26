//
//  DryCleanServerTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanServerTableViewCell.h"
#import "UIImage+QUAdditons.h"


@interface DryCleanServerTableViewCell ()
@property(nonatomic,strong) UIView*        jianView;
@property(nonatomic,strong) UIView*        addView;
@end


@implementation DryCleanServerTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIView *superView = self.contentView;
        
        self.thumbImgView = [superView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        
        self.priceLable = [superView newUILableWithText:@"" textColor:[UIColor redColor] font:font];
        
        //self.jianBtn = [superView newUIButtonWithTarget:self mehotd:@selector(jianCountMethod:) title:@"-" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:20]];
        self.countLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font textAlignment:QU_TextAlignmentCenter];
        //self.addBtn = [superView newUIButtonWithTarget:self mehotd:@selector(addCountMethod:) title:@"+" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:20]];
        
        UIView *aView = ({
            UIView *view = [superView newUIView];
            UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTapJian:)];
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [view addGestureRecognizer:singleRecognizer];
            
            UILabel *lable = [view newUILableWithText:@"-" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:QU_TextAlignmentCenter];
            lable.backgroundColor = [UIColor colorWithRed:0.518 green:0.753 blue:0.125 alpha:1.000];
            lable.layer.cornerRadius = 3;
            lable.layer.masksToBounds = YES;
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.centerX.equalTo(view);
                make.width.height.equalTo(35);
            }];
            view;
        });
        UIView *bView = ({
            UIView *view = [superView newUIView];
            UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTapAdd:)];
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [view addGestureRecognizer:singleRecognizer];
            
            UILabel *lable = [view newUILableWithText:@"+" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:QU_TextAlignmentCenter];
            lable.backgroundColor = [UIColor colorWithRed:0.518 green:0.753 blue:0.125 alpha:1.000];
            lable.layer.cornerRadius = 3;
            lable.layer.masksToBounds = YES;
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.centerX.equalTo(view);
                make.width.height.equalTo(30);
            }];
            view;
        });
        self.jianView = aView;
        self.addView = bView;
        
//        UIColor *color = [UIColor colorWithRed:0.518 green:0.753 blue:0.125 alpha:1.000];
//        UIImage *img = [UIImage imageFromColor:color targetSize:CGSizeMake(40, 40)];
//        [self.jianBtn setBackgroundImage:img forState:UIControlStateNormal];
//        [self.addBtn setBackgroundImage:img forState:UIControlStateNormal];
//        self.jianBtn.layer.cornerRadius = 3;
//        self.jianBtn.layer.masksToBounds = YES;
//        self.addBtn.layer.cornerRadius = 3;
//        self.addBtn.layer.masksToBounds = YES;
        
        [self.thumbImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.width.equalTo(_thumbImgView.mas_height).multipliedBy(0.8);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_thumbImgView.right).offset(padding/2);
            make.top.equalTo(_thumbImgView.mas_top);
            make.bottom.equalTo(_thumbImgView.mas_centerY);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_thumbImgView.mas_centerY);
            make.bottom.equalTo(_thumbImgView.mas_bottom);
        }];
        
        [bView makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(superView);
            make.right.equalTo(superView.right).offset(-padding);
            make.width.equalTo(30);
        }];
        [aView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.equalTo(bView);
            make.right.equalTo(_countLable.left);
            make.left.greaterThanOrEqualTo(_nameLable.right).offset(padding/2);
        }];
        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(30);
            make.right.equalTo(bView.left);
            make.top.bottom.equalTo(aView);
        }];
        
//        [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
//            //make.top.equalTo(superView.top).offset(padding/2);
//            //make.bottom.equalTo(superView.bottom).offset(-padding/2);
//            //make.width.equalTo(_addBtn.mas_height);
//            make.width.height.equalTo(45);
//            make.centerY.equalTo(superView.centerY);
//            make.right.equalTo(superView.right).offset(-padding);
//        }];
//        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(30);
//            make.right.equalTo(_addBtn.left);
//            make.top.bottom.equalTo(_addBtn);
//        }];
//        [self.jianBtn makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.centerY.equalTo(_addBtn);
//            make.right.equalTo(_countLable.left);
//            make.left.greaterThanOrEqualTo(_nameLable.right).offset(padding/2);
//        }];
//        
        
        self.count = 0;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCount:(int)count
{
    _count = count;
    
    [self loadUIWithCount];
}


-(void)loadUIWithCount
{
    if (_count > 0) {
        self.countLable.hidden = NO;
        self.jianView.hidden = NO;
    } else {
        self.countLable.hidden = YES;
        self.jianView.hidden = YES;
    }
    self.countLable.text = [NSString stringWithFormat:@"%i", _count];
}

-(void)SingleTapJian:(UITapGestureRecognizer*)recognizer
{
    [self jianCountMethod:nil];
}

-(void)SingleTapAdd:(UITapGestureRecognizer*)recognizer
{
    [self addCountMethod:nil];
}

-(void)jianCountMethod:(UIButton *)sender
{
    if (_count > 0) {
        self.count --;
        
        if (self.jianCallBack)
            self.jianCallBack(_count);
    }
}


-(void)addCountMethod:(UIButton *)sender
{
    self.count ++;
    
    if (self.addCallBack)
        self.addCallBack(_count);
}

@end
