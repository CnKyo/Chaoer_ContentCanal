//
//  ShopVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopVC : BaseVC

@property (weak, nonatomic) IBOutlet UILabel *mYue;

@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
- (IBAction)goJYClick:(id)sender;

- (IBAction)goBillClick:(id)sender;
- (IBAction)goDpdzClick:(id)sender;

- (IBAction)MenuClick:(id)sender;
@end
