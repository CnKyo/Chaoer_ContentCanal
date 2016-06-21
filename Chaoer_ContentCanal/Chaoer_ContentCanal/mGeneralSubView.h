//
//  mGeneralSubView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGeneralSubView : UIView
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn;
/**
 *  标题  
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  起泡
 */
@property (weak, nonatomic) IBOutlet UILabel *mBage;

+ (mGeneralSubView *)shareView;

+ (mGeneralSubView *)shareSubView;
@end
