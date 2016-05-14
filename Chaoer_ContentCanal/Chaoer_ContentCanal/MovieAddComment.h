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
 *  提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;
/**
 *  评价内容
 */
@property (weak, nonatomic) IBOutlet IQTextView *mContent;

/**
 *  总体评价
 */
@property(strong,nonatomic) IBOutlet UIView *v_star;
/**
 *  速度
 */
@property (weak, nonatomic) IBOutlet UIView *mSpeedView;
/**
 *  质量
 */
@property (weak, nonatomic) IBOutlet UIView *mMassView;


@property(strong,nonatomic) IBOutlet UIView *v_count;
@property(strong,nonatomic) IBOutlet UIView *v_main;
@property(strong,nonatomic) IBOutlet UILabel *lbl_count;
/**
 *  总体评价
 */
@property(strong,nonatomic) IBOutlet UILabel *lbl_counttext;
/**
 *  速度
 */
@property (weak, nonatomic) IBOutlet UILabel *mSpeedLb;
/**
 *  质量
 */
@property (weak, nonatomic) IBOutlet UILabel *mMassLb;
@property (weak, nonatomic) IBOutlet UIView *mCancle;

/**
 *总体评价
 */
@property(strong,nonatomic) IBOutlet UIImageView *img_star1;
@property(strong,nonatomic) IBOutlet UIImageView *img_star2;
@property(strong,nonatomic) IBOutlet UIImageView *img_star3;
@property(strong,nonatomic) IBOutlet UIImageView *img_star4;
@property(strong,nonatomic) IBOutlet UIImageView *img_star5;

/**
 *  速度
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSpeed1;
@property (weak, nonatomic) IBOutlet UIImageView *mSpeed2;
@property (weak, nonatomic) IBOutlet UIImageView *mSpeed3;
@property (weak, nonatomic) IBOutlet UIImageView *mSpeed4;
@property (weak, nonatomic) IBOutlet UIImageView *mSpeed5;


/**
 *  质量
 */
@property (weak, nonatomic) IBOutlet UIImageView *mMass1;
@property (weak, nonatomic) IBOutlet UIImageView *mMass2;
@property (weak, nonatomic) IBOutlet UIImageView *mMass3;
@property (weak, nonatomic) IBOutlet UIImageView *mMass4;
@property (weak, nonatomic) IBOutlet UIImageView *mMass5;



@property NSInteger count;
@property BOOL canAddStar;

- (id)initWithFrame:(CGRect)frame;
-(void)cleamCount;



@end
