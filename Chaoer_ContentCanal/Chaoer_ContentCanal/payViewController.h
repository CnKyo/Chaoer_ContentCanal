//
//  payViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface payViewController : BaseVC
/**
 *  物管费
 */
@property (strong, nonatomic) IBOutlet UIButton *mCanalBtn;
/**
 *  水电气费
 */
@property (strong, nonatomic) IBOutlet UIButton *mThreeBtn;
/**
 *  停车费
 */
@property (strong, nonatomic) IBOutlet UIButton *mParkBtn;

/**
 *  物管待缴
 */
@property (strong, nonatomic) IBOutlet UILabel *mCanalBagdge;
/**
 *  水电气代缴
 */
@property (strong, nonatomic) IBOutlet UILabel *mThreeBadge;
/**
 *  停车费待缴
 */
@property (strong, nonatomic) IBOutlet UILabel *mParkBadge;




@end
