//
//  homeNavView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeNavView : UIView
/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;

+ (homeNavView *)shareView;
@end
