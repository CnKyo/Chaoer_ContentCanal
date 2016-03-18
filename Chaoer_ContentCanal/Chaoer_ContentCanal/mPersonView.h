//
//  mPersonView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mPersonView : UIView
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIButton *mHeaderBtn;

/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  身份
 */
@property (strong, nonatomic) IBOutlet UILabel *mJob;


/**
 *  积分
 */
@property (strong, nonatomic) IBOutlet UILabel *mScore;



/**
 *  等级
 */
@property (strong, nonatomic) IBOutlet UILabel *mLevel;



/**
 *  初始化方法
 *
 *  @return view
 */
+ (mPersonView *)shareView;

/**
 *  消息按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mMessageBtn;
/**
 *  气泡
 */
@property (strong, nonatomic) IBOutlet UILabel *mBadg;
/**
 *  初始化右边的view
 *
 *  @return 　view
 */
+ (mPersonView *)shareRightView;

@end
