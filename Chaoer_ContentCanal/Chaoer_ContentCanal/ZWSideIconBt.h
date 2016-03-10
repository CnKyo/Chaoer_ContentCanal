//
//  ZWSideIconBt.h
//  O2O_Communication_seller
//
//  Created by zzl on 15/12/17.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWSideIconBt : UIButton


//在设置 text之后调用,,这个函数会调整BT的大小,
-(void)setSideIcon:(UIImage*)image atLeft:(BOOL)atLeft;//图标显示在坐标,否则右边

@end
