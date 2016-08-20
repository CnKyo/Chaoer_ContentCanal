//
//  mFoodShopCarCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKFoodShopCarCellDelegate <NSObject>

@optional

- (void)WKFoodShopCarCellWithJianAction:(NSInteger)mIndex indexPath:(NSIndexPath *)mIndexPath;

- (void)WKFoodShopCarCellWithAddAction:(NSInteger)mIndex indexPath:(NSIndexPath *)mIndexPath;

@end

@interface mFoodShopCarCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UIButton *mJianBtn;

@property (weak, nonatomic) IBOutlet UILabel *mNum;

@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;

@property (strong,nonatomic) NSIndexPath *mIndexPath;

@property (strong, nonatomic) id<WKFoodShopCarCellDelegate>delegate;

@end
