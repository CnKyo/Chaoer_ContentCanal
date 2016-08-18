//
//  ShopCommentTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoSize.h"
#import "RatingBar.h"
#import "RateView.h"

@interface ShopCommentTableViewCell : UITableViewCell
@property(strong, nonatomic) UIImageView*       iconImgView;
@property(strong, nonatomic) UILabel*           nikeLable;
@property(strong, nonatomic) RateView*         barView;
@property(strong, nonatomic) UILabel*           commentLable;
@property(strong, nonatomic) UILabel*           timeLable;

@property(strong, nonatomic) UIView*            imgContentView;//当有图片时，imgview组装在这个view里面
@property(strong, nonatomic) UIImageView*       pingImgView1;
@property(strong, nonatomic) UIImageView*       pingImgView2;
@property(strong, nonatomic) UIImageView*       pingImgView3;
@property(strong, nonatomic) UIImageView*       pingImgView4;

-(void)loadUIWithData;

@end