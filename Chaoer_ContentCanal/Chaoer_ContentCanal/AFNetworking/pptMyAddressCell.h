//
//  pptMyAddressCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptMyAddressCell : UITableViewCell
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mTag;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTagLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mDetailLeft;

@end
