//
//  MovieAddComment.h
//  qukan43
//
//  Created by yang on 15/12/3.
//  Copyright © 2015年 ReNew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

///代理方法
@protocol MoveViewDelagate <NSObject>

@optional
///是否成功
- (void)isSucess:(BOOL)mSucess;

@end



@interface MovieAddComment : UIView


@property (nonatomic,strong) id <MoveViewDelagate> delegate;


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


/**
 *  标签view
 */
@property (weak, nonatomic) IBOutlet UIView *mTagView;

/**
 *  跑腿类型 1是商品买送 2是事情办理 3是送东西
 */
@property (nonatomic,assign) int mType;
@property (strong,nonatomic) GPPTOrder *mOrder;
@property (strong,nonatomic)NSString *mLng;

@property (strong,nonatomic)NSString *mLat;

@property NSInteger count;
@property BOOL canAddStar;

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)mArr;
-(void)cleamCount;



@end
