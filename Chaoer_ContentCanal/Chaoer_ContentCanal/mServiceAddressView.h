//
//  mServiceAddressView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mGeneralSubView.h"
@interface mServiceAddressView : UIView


#pragma mark----便民服务小子视图
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSmallImg;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mSmallT;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSmallBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mServiceAddressView *)shareSmallSubView;

@end
