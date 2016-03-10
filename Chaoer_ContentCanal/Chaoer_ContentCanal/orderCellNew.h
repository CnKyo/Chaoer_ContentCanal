//
//  orderCellNew.h
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/23.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderCellNew : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mwarper;

@property (weak, nonatomic) IBOutlet UIView *mtopbgview;
@property (weak, nonatomic) IBOutlet UILabel *mNumId;
@property (weak, nonatomic) IBOutlet UILabel *mOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *mPayStatus;
@property (weak, nonatomic) IBOutlet UILabel *mPayInfo;


@property (strong,nonatomic) SOrder *model;


@end
