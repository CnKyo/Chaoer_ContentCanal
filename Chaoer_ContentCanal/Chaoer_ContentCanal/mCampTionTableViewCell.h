//
//  mCampTionTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图片代理方法
 */
@protocol WKCellWithCheckImgsDelegate <NSObject>

@optional
/**
 *  查看图片方法
 *
 *  @param mIndex 索引
 */
- (void)cellWithCheckImgIndex:(NSInteger)mIndex;

@end

@interface mCampTionTableViewCell : UITableViewCell
#pragma mark----cell样式1
/**
 *  活动标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mCampName;
/**
 *  活动内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mCampContent;

#pragma mark----cell样式2
/**
 *  图片view
 */
@property (weak, nonatomic) IBOutlet UIView *mImgArrView;
/**
 *  分类
 */
@property (weak, nonatomic) IBOutlet UILabel *mClassc;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  代理
 */
@property (strong,nonatomic) id<WKCellWithCheckImgsDelegate>delegate;

@end
