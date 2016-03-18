//
//  mGeneralSubView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGeneralSubView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *mImg;

@property (strong, nonatomic) IBOutlet UIButton *mBtn;

@property (strong, nonatomic) IBOutlet UILabel *mName;

+ (mGeneralSubView *)shareView;
@end
