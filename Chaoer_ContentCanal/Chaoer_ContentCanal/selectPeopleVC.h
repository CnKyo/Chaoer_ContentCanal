//
//  selectPeopleVC.h
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/11.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@class SOrder;
@interface selectPeopleVC : BaseVC

@property (nonatomic,strong)    SOrder*     mTagOrder;
@property (nonatomic,strong)    void(^mitblock)(int staffid);


@end
