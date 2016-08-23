//
//  mPayFeeBarCodeView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mPayFeeBarCodeView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UIButton *mCloseBtn;

+ (mPayFeeBarCodeView *)shareView;
@end
