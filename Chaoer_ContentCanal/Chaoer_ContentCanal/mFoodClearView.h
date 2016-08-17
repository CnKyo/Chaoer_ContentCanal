//
//  mFoodClearView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFoodClearView : UIView
/**
 *  清空购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mClearnBtn;

+ (mFoodClearView *)shareView;
@end
