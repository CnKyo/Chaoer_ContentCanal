//
//  mJoinActivityViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mJoinActivityViewController : BaseVC
/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mName;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mPhone;
/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mAddress;
/**
 *  确定按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mOKBn;



@end
