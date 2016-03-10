//
//  ServiceHeadView.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceHeadView : UIView

@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *mCheckBT;
@property (weak, nonatomic) IBOutlet UIButton *mEditBT;
@property (weak, nonatomic) IBOutlet UIView *mSearchView;
@property (weak, nonatomic) IBOutlet UILabel *mText;
@property (weak, nonatomic) IBOutlet UILabel *mQuanxuan;

+ (ServiceHeadView *)shareView;

@end
