//
//  mAddressView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mAddressView : UIView

/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;
@property (strong, nonatomic) IBOutlet UIView *mLine;

/**
 *  初始化通用地址方法
 *
 *  @return
 */
+ (mAddressView *)shareView;

/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;

/**
 *  帐号
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;

/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;

/**
 *  充值金额
 */
@property (strong, nonatomic) IBOutlet UITextField *mMoneyTx;


/**
 *  支付方式view
 */
@property (strong, nonatomic) IBOutlet UIView *mPayTypeView;
/**
 *  银行卡
 */
@property (strong, nonatomic) IBOutlet UIButton *bankBtn;
/**
 *  微信
 */
@property (strong, nonatomic) IBOutlet UIButton *wechatBtn;
/**
 *  支付宝
 */
@property (strong, nonatomic) IBOutlet UIButton *alipayBtn;

/**
 *  支付按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mPayBtn;

/**
 *  初始化支付方法
 *
 *  @return view
 */
+ (mAddressView *)sharePayView;


/**
 *  医护头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mUserImg;
/**
 *  用户名
 */
@property (strong, nonatomic) IBOutlet UILabel *mUserName;
/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mUserMoney;
/**
 *  初始化用户信息方法
 *
 *  @return view
 */
+ (mAddressView *)shareUsrInfo;





#pragma mark----通用购物车

/**
 *  购物车
 */
@property (strong, nonatomic) IBOutlet UIButton *mShopCar;
/**
 *  价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  配送费
 */
@property (strong, nonatomic) IBOutlet UILabel *mDistribution;
/**
 *  确认下单
 */
@property (strong, nonatomic) IBOutlet UIButton *mGoPay;
/**
 *  气泡
 */
@property (strong, nonatomic) IBOutlet UILabel *mBadge;

/**
 *  初始化购物车方法
 *
 *  @return 
 */
+ (mAddressView *)shareShopCar;


#pragma mark----付款详情

/**
 *  关闭按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCloseBtn;
/**
 *  输入地址
 */
@property (strong, nonatomic) IBOutlet UITextField *mAddressTx;
/**
 *  商品名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  付款金额
 */
@property (strong, nonatomic) IBOutlet UILabel *mPayMoney;
/**
 *  支付方式view
 */
@property (strong, nonatomic) IBOutlet UIView *mPayDetailType;
/**
 *  备注
 */
@property (strong, nonatomic) IBOutlet UITextView *mNoteTxView;

/**
 *  确认付款
 */
@property (strong, nonatomic) IBOutlet UIButton *mGoPayBtn;
/**
 *  初始化付款详情
 *
 *  @return 
 */
+ (mAddressView *)sharepayDetailView;


#pragma mark----商品详情
/**
 *  商品详情图片view
 */
@property (strong, nonatomic) IBOutlet UIView *mGoodsImgView;
/**
 *  商品详情名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsDetailName;
/**
 *  商品详情说明
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsBrief;
/**
 *  商品详情价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsDetailPrice;
/**
 *  邮费
 */
@property (strong, nonatomic) IBOutlet UILabel *mPostPrice;
/**
 *  销量
 */
@property (strong, nonatomic) IBOutlet UILabel *mSalseNum;
/**
 *  商品详情数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsDetailNum;
/**
 *  商品详情添加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mGoodsDetailAddbtn;
/**
 *  商品详情减按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mGoodsDetailDelBtn;

/**
 *  初始化商品详情方法
 *
 *  @return view
 */
+ (mAddressView *)shareGoodsDetailView;

@end
