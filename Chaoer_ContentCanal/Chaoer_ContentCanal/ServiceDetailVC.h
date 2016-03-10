//
//  ServiceDetailVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailVC : BaseVC

@property (nonatomic,strong) SGoodsCate *mCate;
@property (nonatomic,assign) int type;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mBottomHeight;
- (IBAction)mXiaJiaClick:(id)sender;
- (IBAction)mDeletClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mLeft;
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;

@end
