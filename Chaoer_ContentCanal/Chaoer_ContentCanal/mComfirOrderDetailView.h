//
//  mComfirOrderDetailView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mComfirOrderDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *mBigImg;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@property (weak, nonatomic) IBOutlet UILabel *mDetail;

+ (mComfirOrderDetailView *)shareView;

@end
