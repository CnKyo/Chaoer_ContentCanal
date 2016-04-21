//
//  mCookDetailView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCookDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mFood;

@property (weak, nonatomic) IBOutlet UILabel *mDesctription;

+ (mCookDetailView *)shareView;
@end
