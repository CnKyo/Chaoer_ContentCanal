//
//  mComfirmHederAndFooterSection.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理方法
 */
@protocol mSectionDelegate <NSObject>

@optional
/**
 *  配送方式
 *
 *  @param mIndexPath 索引
 */
- (void)sectionWithSendType:(NSInteger)mIndexPath;
/**
 *  优惠券
 *
 *  @param mIndexPath 索引
 */
- (void)sectionWithCoup:(NSInteger)mIndexPath;
/**
 *  留言
 *
 *  @param mIndexPath 索引
 */
- (void)sectionWithMessage:(NSInteger)mIndexPath;

@end

@interface mComfirmHederAndFooterSection : UIView

#pragma mark ---- headerSection
/**
 *  店铺图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopImg;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mComfirmHederAndFooterSection *)shareHeader;

#pragma mark ---- footerSection
@property (weak, nonatomic) IBOutlet UILabel *mSendTypeLB;

/**
 *  配送方式
 */
@property (weak, nonatomic) IBOutlet UIButton *mSenderType;
/**
 *  优惠券
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoup;
/**
 *  留言
 */
@property (weak, nonatomic) IBOutlet UILabel *mMsg;
/**
 *  留言按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mMsgBtn;
/**
 *  金额
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mMoney;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mComfirmHederAndFooterSection *)shareFooter;


/**
 *  索引
 */
@property (nonatomic,assign) NSIndexPath *mIndexPaths;

@property (nonatomic,assign) NSInteger mSection;

@property (strong,nonatomic) id<mSectionDelegate> delegate;

@end
