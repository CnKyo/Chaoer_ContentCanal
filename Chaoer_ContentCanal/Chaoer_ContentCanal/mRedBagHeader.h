//
//  mRedBagHeader.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mRedBagHeader : UIView
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIButton *mHeaderBtn;
/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  签名
 */
@property (strong, nonatomic) IBOutlet UILabel *mDEtail;

+ (mRedBagHeader *)shareView;
@end
