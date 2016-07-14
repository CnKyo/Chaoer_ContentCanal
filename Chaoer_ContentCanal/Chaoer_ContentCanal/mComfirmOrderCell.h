//
//  mComfirmOrderCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mComfirmOrderCell;
@protocol WKComfirDelegate <NSObject>

@optional
/**
 *  选择图片方法
 *
 *  @param cell   cell
 *  @param mIndex 索引
 */
- (void)cellDidCheckImage:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex;
/**
 *  选择配送方式方法
 *
 *  @param cell   cell
 *  @param mIndex 索引
 */
- (void)cellDidChioceSendType:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex;
/**
 *  选择优惠卷方法
 *
 *  @param cell   cell
 *  @param mIndex 索引
 */
- (void)cellDidSelectedCoup:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex;
/**
 *  选择留言方法
 *
 *  @param cell   cell
 *  @param mIndex 索引
 */
- (void)cellDidMessageNote:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex;

@end

@interface mComfirmOrderCell : UITableViewCell
/**
 *  店铺图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mStoreImg;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mStoreName;
/**
 *  图片view
 */
@property (weak, nonatomic) IBOutlet UIView *mImagesView;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mProductNum;
/**
 *  查看商品
 */
@property (weak, nonatomic) IBOutlet UIButton *mcheckProduct;
/**
 *  配送方式
 */
@property (weak, nonatomic) IBOutlet UILabel *mSenType;
/**
 *  选择配送方式按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSendTypeBtn;
/**
 *  优惠卷
 */
@property (weak, nonatomic) IBOutlet UILabel *mCoup;
/**
 *  回显优惠信息
 */
@property (weak, nonatomic) IBOutlet UILabel *mCoupContent;
/**
 *  选择优惠卷按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;
/**
 *  留言按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mNoteBtn;
/**
 *  总价信息
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotalMoney;

/**
 *  索引
 */
@property (nonatomic, weak) NSIndexPath *indexPath;
/**
 *  代理方法
 */
@property (nonatomic, weak) id<WKComfirDelegate> cellDelegate;

@end
