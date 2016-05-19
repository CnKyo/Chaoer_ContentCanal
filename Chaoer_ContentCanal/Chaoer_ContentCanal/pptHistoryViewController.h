//
//  pptHistoryViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface pptHistoryViewController : BaseVC
/**
 *  1是其它  2是本身
 */
@property (assign,nonatomic) int mType;


@property (strong,nonatomic)NSString *mLng;

@property (strong,nonatomic)NSString *mLat;

@end
