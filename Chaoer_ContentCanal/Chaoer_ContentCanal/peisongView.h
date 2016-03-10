//
//  peisongView.h
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface peisongView : UIView

@property (weak, nonatomic) IBOutlet UIButton *mFirstTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *mSeconTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;

@property (weak, nonatomic) IBOutlet UIButton *mJianBtn;


+ (peisongView *)shareView;

+ (peisongView *)shareJianView;
@end
