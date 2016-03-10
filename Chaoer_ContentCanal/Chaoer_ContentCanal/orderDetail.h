//
//  orderDetail.h
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/2.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@class SOrder;
@class ZWSideIconBt;
@interface orderDetail : BaseVC

@property (weak, nonatomic) IBOutlet UIScrollView *mwarper;
@property (weak, nonatomic) IBOutlet UILabel *morderstatus;

@property (weak, nonatomic) IBOutlet UIView *msendwarper;
@property (weak, nonatomic) IBOutlet UILabel *mnametel;

@property (weak, nonatomic) IBOutlet UIView *maddrwaper;
@property (weak, nonatomic) IBOutlet UILabel *maddr;
@property (weak, nonatomic) IBOutlet UILabel *mdist;

@property (weak, nonatomic) IBOutlet UILabel *msendtime;
@property (weak, nonatomic) IBOutlet UIView *mlocinfowaper;

@property (weak, nonatomic) IBOutlet UIView *mgoodsinfowaper;
@property (weak, nonatomic) IBOutlet UITableView *mgoodtable;


@property (weak, nonatomic) IBOutlet UIView *morderinfowaper;
@property (weak, nonatomic) IBOutlet UIView *mordersubwaper;

@property (weak, nonatomic) IBOutlet UILabel *mpaytype;
@property (weak, nonatomic) IBOutlet UILabel *nordersn;
@property (weak, nonatomic) IBOutlet UILabel *msellername;
@property (weak, nonatomic) IBOutlet UILabel *mcreatetime;
@property (weak, nonatomic) IBOutlet UILabel *mapptime;
@property (weak, nonatomic) IBOutlet UILabel *mremark;
@property (weak, nonatomic) IBOutlet UIView *msenderwaper;
@property (weak, nonatomic) IBOutlet UILabel *msendername;

@property (nonatomic,strong)ZWSideIconBt*   mtelbt;
@property (nonatomic,strong)ZWSideIconBt*   mchangebt;


@property (weak, nonatomic) IBOutlet UIView *mtwowaper;
@property (weak, nonatomic) IBOutlet UIView *mthreewaper;
@property (weak, nonatomic) IBOutlet UIView *monewaper;








@property (nonatomic,strong)    SOrder* mtagOrder;

@end
