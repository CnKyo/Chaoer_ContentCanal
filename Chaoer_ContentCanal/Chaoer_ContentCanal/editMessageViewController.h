//
//  editMessageViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface editMessageViewController : BaseVC
/**
 *  标题
 */
@property (nonatomic,strong) NSString   *mTitel;

@property (nonatomic,strong) NSString   *mPlaceholder;

@property (nonatomic,strong) NSString   *mtext;


/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  输入看
 */
@property (strong, nonatomic) IBOutlet UITextField *mTx;
/**
 *  状态
 */
@property (strong, nonatomic) IBOutlet UILabel *mStatus;

@property (nonatomic,strong) void(^block)(NSString *block);
/**
 *  参数类型：1是昵称 2是个性签名
 */
@property (nonatomic,assign) int    mtype;

@end
