//
//  mFeedBackViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mFeedBackViewController : BaseVC
/**
 *  居民
 */
@property (strong, nonatomic) IBOutlet UIButton *mPerson;
/**
 *  物管
 */
@property (strong, nonatomic) IBOutlet UIButton *mCanal;
/**
 *  公司
 */
@property (strong, nonatomic) IBOutlet UIButton *mCompany;
@end
