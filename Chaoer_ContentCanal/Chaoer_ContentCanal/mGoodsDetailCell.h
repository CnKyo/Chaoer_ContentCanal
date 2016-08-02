//
//  mGoodsDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  查看更多活动代理方法
 */
@protocol cellCheckMoreActivityDelegate <NSObject>

@optional
/**
 *  实现代理方法
 */
- (void)cellWithCheckMoreActivityBtn;

@end

@interface mGoodsDetailCell : UITableViewCell


#pragma mark----第一种cell类型

/**
 *  图片数组
 */
@property (strong,nonatomic) NSArray *mImgArr;
/**
 *  商品对象
 */
@property (strong,nonatomic) SGoodsDetail *mGoodsDetail;

#pragma mark ----第二种cell样式
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  现价
 */
@property (weak, nonatomic) IBOutlet UILabel *mNoewPrice;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *mOldPrice;
/**
 *  营业时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mWorkTime;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSalesNum;
/**
 *  配送费
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendPrice;
/**
 *  活动标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mActivTag;
/**
 *  活动内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mActivContent;
/**
 *  查看更多
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckMore;
/**
 *  关注
 */
@property (weak, nonatomic) IBOutlet UILabel *mFocus;
/**
 *  库存
 */
@property (weak, nonatomic) IBOutlet UILabel *mInventry;

@property (weak, nonatomic) IBOutlet UILabel *mActTitle;

@property (strong,nonatomic) id<cellCheckMoreActivityDelegate> delegate;

@end
