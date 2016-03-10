//
//  searchView.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgkVC;

@property (weak, nonatomic) IBOutlet UIButton *mSearchBtn;

@property (weak, nonatomic) IBOutlet UISearchBar *mSearch;

+ (searchView *)shareView;
@end
