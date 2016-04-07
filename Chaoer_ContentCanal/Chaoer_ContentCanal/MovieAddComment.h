//
//  MovieAddComment.h
//  qukan43
//
//  Created by yang on 15/12/3.
//  Copyright © 2015年 ReNew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface MovieAddComment : UIView

@property (strong,nonatomic) UIView *v_addcomment;
/**
 *  状态logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mStatusLogo;
/**
 *  状态标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatusLb;
/**
 *  状态主图
 */
@property (weak, nonatomic) IBOutlet UIImageView *mStatusImg;
/**
 *  提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;
/**
 *  评价内容
 */
@property (weak, nonatomic) IBOutlet IQTextView *mContent;


@property(strong,nonatomic) IBOutlet UIView *v_star;
@property(strong,nonatomic) IBOutlet UIView *v_count;
@property(strong,nonatomic) IBOutlet UIView *v_main;
@property(strong,nonatomic) IBOutlet UILabel *lbl_count;
@property(strong,nonatomic) IBOutlet UILabel *lbl_counttext;


@property(strong,nonatomic) IBOutlet UIImageView *img_star1;
@property(strong,nonatomic) IBOutlet UIImageView *img_star2;
@property(strong,nonatomic) IBOutlet UIImageView *img_star3;
@property(strong,nonatomic) IBOutlet UIImageView *img_star4;
@property(strong,nonatomic) IBOutlet UIImageView *img_star5;


@property NSInteger count;
@property BOOL canAddStar;

- (id)initWithFrame:(CGRect)frame;
-(void)cleamCount;



@end
