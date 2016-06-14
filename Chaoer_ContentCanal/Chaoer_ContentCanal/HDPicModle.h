//
//  HDPicModle.h
//  PortableTreasure
//
//  Created by HeDong on 16/2/10.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDPicModle : NSObject

/**
 *  上传的图片的名字
 */
@property (nonatomic, copy) NSString *mPicName;

/**
 *  上传的图片
 */
@property (nonatomic, strong, nullable) UIImage *mPicImage;

/**
 *  上传的二进制文件
 */
@property (nonatomic, strong) NSData *mPicData;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSString *mPicUrl;

@end

NS_ASSUME_NONNULL_END