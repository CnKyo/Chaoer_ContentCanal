//
//  ShopCommentTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ShopCommentTableViewCell.h"

@implementation ShopCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIView *superView = self.contentView;
        
        
        
        UIView *aView = ({
            UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
            
            self.nikeLable = [view newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
            self.barView = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
            [view addSubview:_barView];
            
            self.commentLable = [view newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
            self.commentLable.numberOfLines = 0;
            
            
            self.imgContentView = ({
                UIView *vi = [view newUIView];
                
                self.pingImgView1 = [vi newUIImageViewWithImg:IMG(@"DefaultImg.png")];
                self.pingImgView2 = [vi newUIImageViewWithImg:IMG(@"DefaultImg.png")];
                self.pingImgView3 = [vi newUIImageViewWithImg:IMG(@"DefaultImg.png")];
                self.pingImgView4 = [vi newUIImageViewWithImg:IMG(@"DefaultImg.png")];
                [self.pingImgView1 makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(vi);
                }];
                [self.pingImgView2 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.width.height.equalTo(_pingImgView1);
                    make.left.equalTo(_pingImgView1.mas_right).offset(padding);
                }];
                [self.pingImgView3 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.width.height.equalTo(_pingImgView1);
                    make.left.equalTo(_pingImgView2.mas_right).offset(padding);
                }];
                [self.pingImgView4 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.width.height.equalTo(_pingImgView1);
                    make.left.equalTo(_pingImgView3.mas_right).offset(padding);
                    make.right.equalTo(vi.mas_right);
                }];
                vi;
            });
            
            
            self.timeLable = [view newUILableWithText:@"" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13]];
            
            [self.nikeLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(30);
                make.top.equalTo(view.mas_top).offset(padding/2);
                make.height.equalTo(25);
                make.right.equalTo(_barView.mas_left);
            }];
            [self.barView makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view.mas_right);
                make.top.equalTo(view.mas_top).offset(padding/2);
            }];
            [self.commentLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_nikeLable.mas_left);
                make.right.equalTo(view.mas_right).offset(-padding/2);
                make.top.equalTo(_nikeLable.mas_bottom);
            }];
            [self.imgContentView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(_commentLable);
                make.top.equalTo(_commentLable.mas_bottom).offset(padding/2);
                make.height.equalTo(_imgContentView.mas_width).multipliedBy(0.2);
            }];
            [self.timeLable makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_commentLable.mas_right);
                make.top.equalTo(_imgContentView.mas_bottom).offset(padding/2);
                make.height.equalTo(20);
            }];
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_timeLable.bottom).offset(padding);
            }];
            view;
        });
        
        self.iconImgView = [superView newUIImageViewWithImg:IMG(@"icon_headerdefault.png")];
        
        [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(padding/2);
            make.left.equalTo(superView.left).offset(padding);
            make.width.height.equalTo(35);
        }];
        [aView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImgView.mas_centerY);
            make.left.equalTo(_iconImgView.mas_centerX);
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.bottom.equalTo(superView.mas_bottom).offset(-padding/2);
        }];
        
    }
    return self;
}


-(void)loadUIWithData
{
    self.iconImgView.image = IMG(@"icon_headerdefault.png");
    self.nikeLable.text = @"张三";
    self.commentLable.text = @"pnglasdfasdfasdfadsfasdfalsdfasdlfasdlfasjdflasdflasdflasdfkasdfaksldfasldfasdfas爱上的发生的发生的发生的发生地方爱上的发生的发生的发生的";
    self.timeLable.text = @"2小时以前";
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
