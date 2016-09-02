//
//  NSUserDefaults+Settings.h
//  RaoooScore
//
//  Created by 瞿 伦平 on 13-12-31.
//  Copyright (c) 2013年 Allran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QUCustomDefine.h"

@interface NSUserDefaults (Settings)

@property(nonatomic,strong) NSString*               latitude;                 //
@property(nonatomic,strong) NSString*               longitude;                 //

-(void)loadUserZro;

@end

