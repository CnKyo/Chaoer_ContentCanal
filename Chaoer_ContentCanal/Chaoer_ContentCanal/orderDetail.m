//
//  orderDetail.m
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/2.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "orderDetail.h"
#import "UILabel+myLabel.h"
#import "ordergoodscell.h"
#import <MapKit/MapKit.h>
#import "ReplyView.h"
#import "selectPeopleVC.h"
#import "ZWSideIconBt.h"

@interface orderDetail ()<UITableViewDataSource,UITableViewDelegate>

@end

#define LAW 0.75* DEVICE_Width

@implementation orderDetail
{
    NSMutableArray* _allgoodsinfo;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    //    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"订单详情";
 
    
    CGRect ff = self.mwarper.frame;
    ff.size.height = DEVICE_Height - 64 - 68;
    self.mwarper.frame = ff;
    
    [self.monewaper viewWithTag:1].layer.cornerRadius = 3;
    [self.monewaper viewWithTag:1].layer.borderColor = [UIColor whiteColor].CGColor;
    [self.monewaper viewWithTag:1].layer.borderWidth = 1;
    
    
    _allgoodsinfo = NSMutableArray.new;
    
    UINib * nib = [UINib nibWithNibName:@"ordergoodscell" bundle:nil];
    [self.mgoodtable registerNib:nib  forCellReuseIdentifier:@"cell"];

    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    [[SAppInfo shareClient] getUserLocation:NO block:^(NSString *err) {
        
        if( err )
        {
            [SVProgressHUD showErrorWithStatus:err];
        }
        
        [self.mtagOrder getDetail:^(SResBase *resb) {
            if( resb.msuccess )
            {
                [SVProgressHUD dismiss];
                [self updatePage];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:0.75f];
            }
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateOrderSendInfo
{//配送信息
    self.msendwarper.layer.cornerRadius = 2;
    self.msendwarper.layer.borderWidth = 1;
    self.msendwarper.layer.borderColor = [UIColor colorWithRed:225/255.0f green:224/255.0f blue:223/255.0f alpha:1].CGColor;
    
    if( self.mtagOrder.mName && self.mtagOrder.mMobile )
    {
        NSString* str = [NSString stringWithFormat:@"%@ %@",self.mtagOrder.mName,self.mtagOrder.mMobile];
        NSMutableAttributedString* attrstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:225/255.0f green:224/255.0f blue:223/255.0f alpha:1] range:[str rangeOfString:self.mtagOrder.mMobile]];
        self.mnametel.attributedText = attrstr;
    }
    else
    {
        self.mnametel.text = @"";
        self.mnametel.attributedText = nil;
    }
    
    self.mdist.text = self.mtagOrder.mDistStr;
    self.maddr.text = self.mtagOrder.mAddress;
    [self.maddr autoResizeHeightForContent:CGFLOAT_MAX];
    [Util autoExtendH:self.maddr.superview blow:self.maddr dif:10.0f];
    
    if( self.mtagOrder.mBuyerFinishTime.length )
    {
        self.msendtime.hidden = NO;
        if( self.mtagOrder.mOrderType == 1 )
        {
            self.msendtime.text = [NSString stringWithFormat:@"送达时间:%@",self.mtagOrder.mAppTime];
        }
        else
        {
            self.msendtime.text = [NSString stringWithFormat:@"完成时间:%@",self.mtagOrder.mBuyerFinishTime];
        }
        [Util relPosUI:self.maddrwaper dif:15 tag:self.msendtime tagatdic:E_dic_b];
        [Util autoExtendH:self.msendwarper blow:self.msendtime dif:15];
    }
    else
    {
        self.msendtime.hidden = YES;
        [Util autoExtendH:self.msendwarper blow:self.maddrwaper dif:0];
    }
    
}
-(NSDictionary*)formatNormGoods:(NSArray*)allordergoods
{
    NSMutableDictionary* dic = NSMutableDictionary.new;
    for( SOrderGoods*one in allordergoods )
    {
        NSMutableArray * sub = [dic objectForKey:@(one.mGoodsId)];
        if( sub == nil )
        {
            sub = NSMutableArray.new;
            [dic setObject:sub forKey:@(one.mGoodsId)];
 
        }
        [sub addObject:one];
    }
    return dic;
}
-(void)updateOrderGoodInfo
{
    [Util relPosUI:self.msendwarper dif:8 tag:self.mgoodsinfowaper tagatdic:E_dic_b];
    
    self.mgoodtable.layer.cornerRadius = 2;
    self.mgoodtable.layer.borderWidth = 1;
    self.mgoodtable.layer.borderColor = [UIColor colorWithRed:225/255.0f green:224/255.0f blue:223/255.0f alpha:1].CGColor;
    
    //购买商品详细信息
    [_allgoodsinfo removeAllObjects];
    int     k = 0;
    float   pp = 0.0f;
    CGFloat allheight = 0.0f;
    
    NSDictionary* tmpdealed = [self formatNormGoods:self.mtagOrder.mOrderGoods];
    for( NSArray*one in tmpdealed.allValues )
    {
        if( one.count == 0 ) return;
        
        if( one.count > 1 )//这是有多个规格的情况
        {
            float onetotalprice = 0.0f;
            NSString* goodsname = @"";
            for ( int j = 0; j < one.count; j++ )
            {
                SOrderGoods* oneobj = one[j];
                goodsname = oneobj.mGoodsName;
                
                NSString* n = [NSString stringWithFormat:@" %@",oneobj.mGoodsNorms];
                NSString* c = @"";
                NSString* p = [NSString stringWithFormat:@"￥%.2f x %d",oneobj.mPrice,oneobj.mNum];
                
                NSMutableArray* tttt  = NSMutableArray.new;
                [tttt addObject:n];
                [tttt addObject:c];
                [tttt addObject:p];
                [tttt addObject:@(1)];
                [tttt addObject:@(30.0f)];
                [_allgoodsinfo addObject:tttt];
                allheight += 30.0f;
                
                onetotalprice += oneobj.mPrice * oneobj.mNum;
                
            }
            //这种完了还要处理一个,,,,
            CGFloat th = [goodsname sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(LAW, CGFLOAT_MAX)].height + 22;
            
            th = th < 44.0f ? 44.0f :th;
            
            NSMutableArray* tttt  = NSMutableArray.new;
            [tttt addObject:goodsname];
            [tttt addObject:@""];
            [tttt addObject:[NSString stringWithFormat:@"￥%.2f",onetotalprice]];
            [tttt addObject:@(0)];
            [tttt addObject:@(th)];
            
            [_allgoodsinfo insertObject:tttt atIndex: _allgoodsinfo.count - one.count ];
            
            allheight += th;
            
            pp += onetotalprice;
        }
        else
        {
            //没有规格的时候,或者只有一个有规格的时候
            
            SOrderGoods* oneobj = one[0];
            
            BOOL bhavenorm = oneobj.mGoodsNorms.length > 0;
            
            
            NSString* n = oneobj.mGoodsName;
            NSString* c = @"";
            NSString* p = @"";
            if( bhavenorm )
                p = [NSString stringWithFormat:@"￥%.2f",oneobj.mPrice*oneobj.mNum];//有规格应该显示总价,
            else
                p = [NSString stringWithFormat:@"￥%.2f x %d",oneobj.mPrice,oneobj.mNum];//没有就显示单价 * 数量
            
            CGFloat th = [n sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(LAW, CGFLOAT_MAX)].height + 22;
            th = th < 44.0f ? 44.0f :th;
            
            NSMutableArray* tttt  = NSMutableArray.new;
            [tttt addObject:n];
            [tttt addObject:c];
            [tttt addObject:p];
            [tttt addObject:@(0)];
            [tttt addObject:@(th)];
            [_allgoodsinfo addObject:tttt];
            
            allheight +=  th;
            if( bhavenorm )
            {//如果有规格,还是要
                n = [NSString stringWithFormat:@" %@",oneobj.mGoodsNorms];

                p = [NSString stringWithFormat:@"￥%.2f x %d",oneobj.mPrice,oneobj.mNum];
                NSMutableArray* tttt  = NSMutableArray.new;
                [tttt addObject:n];
                [tttt addObject:c];
                [tttt addObject:p];
                [tttt addObject:@(1)];
                [tttt addObject:@(30.0f)];
                [_allgoodsinfo addObject:tttt];
                
                allheight +=  30;
            }
            
            pp += oneobj.mPrice * oneobj.mNum;
        }
        
    }
    CGFloat xxx = 0.0f;
    if( self.mtagOrder.mDiscountFee != 0.0f )
    {
        [_allgoodsinfo addObject:@[@"优惠券",@"",[NSString stringWithFormat:@"-%.2f",self.mtagOrder.mDiscountFee] ,@(0),@(44.0f)]];
        xxx += 44.0f;
    }
    
    [_allgoodsinfo addObject:@[@"配送费",@"",[NSString stringWithFormat:@"￥%.2f",self.mtagOrder.mFreight] ,@(0),@(44.0f)]];
    xxx += 44.0f;
    [_allgoodsinfo addObject:@[@"合 计",@"",[NSString stringWithFormat:@"￥%.2f",self.mtagOrder.mPayFee] ,@(0),@(44.0f)]];
    xxx += 44.0f;
    
    CGRect f = self.mgoodtable.frame;
    f.size.height = allheight + xxx;
    self.mgoodtable.frame = f;
    
    self.mgoodtable.delegate = self;
    self.mgoodtable.dataSource = self;
    [self.mgoodtable reloadData];
    
    [Util autoExtendH:self.mgoodtable.superview blow:self.mgoodtable dif:0];
    
}
-(void)updateOrderInfo
{
    [Util relPosUI:self.mgoodsinfowaper dif:8 tag:self.morderinfowaper tagatdic:E_dic_b];
    
    self.mordersubwaper.layer.cornerRadius =2;
    self.mordersubwaper.layer.borderWidth = 1;
    self.mordersubwaper.layer.borderColor = [UIColor colorWithRed:225/255.0f green:224/255.0f blue:223/255.0f alpha:1].CGColor;
    
    self.mpaytype.text = [NSString stringWithFormat:@"支付方式:%@",self.mtagOrder.mPayType];
    self.nordersn.text = [NSString stringWithFormat:@"订单编号:%@",self.mtagOrder.mSn];
    self.msellername.text  = [NSString stringWithFormat:@"店铺:%@",self.mtagOrder.mSellerName];
    self.mcreatetime.text = [NSString stringWithFormat:@"顾客下单时间:%@",self.mtagOrder.mCreateTime];
    self.mapptime.text = [NSString stringWithFormat:@"预约到达时间:%@",self.mtagOrder.mAppTime];
    
    if( self.mtagOrder.mBuyRemark.length )
    {
        self.mremark.hidden = NO;
        self.mremark.text = [NSString stringWithFormat:@"备注:%@",self.mtagOrder.mBuyRemark];
        [self.mremark autoResizeHeightForContent:CGFLOAT_MAX];
        [Util relPosUI:self.mremark dif:10 tag:self.msenderwaper tagatdic:E_dic_b];
    }
    else
    {
        self.mremark.hidden = YES;
        [Util relPosUI:self.mapptime dif:10 tag:self.msenderwaper tagatdic:E_dic_b];
    }
    
    NSString* ssa = @"";
    if( self.mtagOrder.mStaff )
    {//如果已经有了,就显示服务人员或者配送人的信息.
        
        if( self.mtagOrder.mOrderType == 1 )
            ssa = [NSString stringWithFormat:@"配送员:%@",self.mtagOrder.mStaff.mName];
        else
            ssa = [NSString stringWithFormat:@"服务人员:%@",self.mtagOrder.mStaff.mName];
        self.msendername.text = ssa;
        
        //要显示电话
        if( self.mtelbt == nil )
        {
            self.mtelbt = [[ZWSideIconBt alloc] initWithFrame:CGRectMake(0, 0, 10, _msenderwaper.frame.size.height)];
            [self.mtelbt setTitleColor: self.morderstatus.textColor forState:UIControlStateNormal];
            [_msenderwaper addSubview:self.mtelbt];
            self.mtelbt.center = CGPointMake(self.mtelbt.center.x, _msenderwaper.frame.size.height/2);
            [self.mtelbt addTarget:self action:@selector(callsendertel:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.mtelbt setTitle:self.mtagOrder.mStaff.mMobile forState:UIControlStateNormal];
        [self.mtelbt setSideIcon:[UIImage imageNamed:@"redtel"] atLeft:NO];
        
        if( self.mtagOrder.mIsCanChangeStaff )
        {//如果可以修改,仅仅多显示一个按钮就行了
            
            if( self.mchangebt == nil )
            {
                self.mchangebt = [[ZWSideIconBt alloc] initWithFrame:CGRectMake(0, 0, 10, _msenderwaper.frame.size.height)];
                [_msenderwaper addSubview:self.mchangebt];
                [self.mchangebt setTitleColor: self.morderstatus.textColor forState:UIControlStateNormal];
                self.mchangebt.center = CGPointMake(self.mchangebt.center.x, _msenderwaper.frame.size.height/2);
                [self.mchangebt addTarget:self action:@selector(changepeople:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.mchangebt setTitle:@"更换" forState:UIControlStateNormal];
            [self.mchangebt setSideIcon:[UIImage imageNamed:@"dp_youjiantou"] atLeft:NO];
            
            //如果有2个按钮,电话那个在左边
            [Util relPosUI:self.mchangebt.superview dif:5 tag:self.mchangebt tagatdic:E_dic_r];
            [Util relPosUI:self.mchangebt dif:5 tag:self.mtelbt tagatdic:E_dic_l];
        }
        else
        {//不能修改,就把修改的改掉,,
            [self.mchangebt removeFromSuperview];
            self.mchangebt = nil;
            
            
            [Util relPosUI:self.mtelbt.superview dif:5 tag:self.mtelbt tagatdic:E_dic_r];
        }
    
    }
    else
    {
        //如果没有,服务人员或者配送人员,,就判断下是不是可以选择
        [self.mtelbt removeFromSuperview];
        self.mtelbt = nil;
        
        //如果没有对象,,就判断,,是否要更换
        if( self.mtagOrder.mIsCanChangeStaff )
        {
            if( self.mtagOrder.mOrderType == 1 )
                ssa = @"请选择配送员";
            else
                ssa = @"请选择服务人员";
            self.msendername.text = ssa;
            
            if( self.mchangebt == nil )
            {
                self.mchangebt = [[ZWSideIconBt alloc] initWithFrame:CGRectMake(0, 0, 10, _msenderwaper.frame.size.height)];
                [_msenderwaper addSubview:self.mchangebt];
                [self.mchangebt setTitleColor: self.morderstatus.textColor forState:UIControlStateNormal];
                self.mchangebt.center = CGPointMake(self.mchangebt.center.x, _msenderwaper.frame.size.height/2);
                [self.mchangebt addTarget:self action:@selector(changepeople:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.mchangebt setTitle:@"更换" forState:UIControlStateNormal];
            [self.mchangebt setSideIcon:[UIImage imageNamed:@"dp_youjiantou"] atLeft:NO];
            [Util relPosUI:self.mchangebt.superview dif:5 tag:self.mchangebt tagatdic:E_dic_r];
        }
        else
        {//如果不能更换,并且也没有对象,,,,???
            
            if( self.mtagOrder.mOrderType == 1 )
                ssa = @"暂无配送员";
            else
                ssa = @"暂无服务人员";
            self.msendername.text = ssa;
            
            [self.mchangebt removeFromSuperview];
            self.mchangebt = nil;
        }
    }
    
    [Util autoExtendH:self.msenderwaper.superview blow:self.msenderwaper dif:7];
}
-(void)updateOrderOpInfo
{
    
    NSMutableArray* tttName = NSMutableArray.new;
    SEL tttSEL[10];
    int selindex = 0;
    
    [tttName addObject:@"导航"];
    tttSEL[selindex] = @selector(callnav:);
    selindex++;
    
    
    if( self.mtagOrder.mIsCanCancel )
    {
        if( [[SUser currentUser] isSeller] )
        {
            [tttName addObject:@"取消订单"];
            tttSEL[selindex] = @selector(callcancle:);
            selindex++;
        }
    }
    if( self.mtagOrder.mIsCanAccept )
    {
        if( [[SUser currentUser] isSeller] )
        {
            [tttName addObject:@"确认订单"];
            tttSEL[selindex] = @selector(callconfirm:);
            selindex++;
        }
    }
    if( self.mtagOrder.mIsCanFinish )
    {
        if( [[SUser currentUser] isSender] || [[SUser currentUser] isServicer]  )
        {
            [tttName addObject:@"订单完成"];
            tttSEL[selindex] = @selector(callcomp:);
            selindex++;
        }
    }
    if( self.mtagOrder.mIsCanStartService )
    {
        if( self.mtagOrder.mOrderType == 1 && [[SUser currentUser] isSender] )
        {
            [tttName addObject:@"开始配送"];
            tttSEL[selindex] = @selector(callstartsrv:);
            selindex++;
        }else
            if( self.mtagOrder.mOrderType == 2 && [[SUser currentUser] isServicer] )
            {
                [tttName addObject:@"开始服务"];
                tttSEL[selindex] = @selector(callstartsrv:);
                selindex++;
            }
            else
            {
                NSLog(@"what's the fuck order type");
            }
    }
    
    NSArray* ttt = @[ UIView.new, self.monewaper,self.mtwowaper,self.mthreewaper ];
    
    
    if( tttName.count > 3 )
    {
        CGRect ff = self.mwarper.frame;
        ff.size.height = DEVICE_Height - 64;
        self.mwarper.frame = ff;
        for ( UIView* one in ttt ) {
            one.hidden = YES;
        }
    }
    else
    {
        UIView* tagwaper = ttt[ tttName.count ];
        for ( int j  = 0 ;j < tttName.count; j ++) {
            UIButton* onebt = (UIButton*)[tagwaper viewWithTag:j+1];
            [onebt setTitle:tttName[j] forState:UIControlStateNormal];
            [onebt removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
            [onebt addTarget:self action:tttSEL[j] forControlEvents:UIControlEventTouchUpInside];
            
        }
        for ( UIView* one in ttt ) {
            if( one != tagwaper )
                one.hidden = YES;
            else
                one.hidden = NO;
        }
        
        CGRect fffft = tagwaper.frame;
        fffft.origin.y = DEVICE_Height - fffft.size.height;
        tagwaper.frame = fffft;
     
        CGRect ff = self.mwarper.frame;
        ff.size.height = DEVICE_Height - 64 - fffft.size.height;
        self.mwarper.frame = ff;
    }
}
- (IBAction)callbuyertel:(id)sender {

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.mtagOrder.mMobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (IBAction)callsendertel:(id)sender {
    
    if( self.mtagOrder.mStaff ){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.mtagOrder.mStaff.mMobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [SVProgressHUD showErrorWithStatus:@"电话信息为空!"];
    }
}


-(void)updatePage
{
    self.morderstatus.text = self.mtagOrder.mOrderStatusStr;
    [self updateOrderSendInfo];
    [self updateOrderGoodInfo];
    [self updateOrderInfo];
    
    CGSize ss = self.mwarper.contentSize;
    ss.height = self.morderinfowaper.frame.origin.y + self.morderinfowaper.frame.size.height;
    self.mwarper.contentSize = ss;
    
    [self updateOrderOpInfo];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allgoodsinfo.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* t = [_allgoodsinfo objectAtIndex:indexPath.row];
    CGFloat H = [t[4] floatValue];;
    NSLog(@"hhh:%f",H);
    return H;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ordergoodscell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray* t = [_allgoodsinfo objectAtIndex:indexPath.row];
    
    cell.mA.text = t[0];
    cell.mB.text = t[1];
    cell.mC.text = t[2];
    
    [cell.mA autoReSizeWidthForContent:LAW];
    
    if( [t[3] intValue] )
    {
        cell.mA.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        cell.mA.textColor = [UIColor whiteColor];
        cell.mA.font = [UIFont systemFontOfSize:12.0f];
        cell.mA.layer.cornerRadius = 3.0f;
        cell.mA.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.mA.layer.borderWidth = 1.0f;
        
        CGRect f = cell.mA.frame;
        f.size.height = 21.0f;
        cell.mA.frame = f;
        cell.mA.numberOfLines = 1;
        
        cell.mA.center = CGPointMake( cell.mA.center.x, [t[4] floatValue]/2);
        
    }
    else
    {
        cell.mA.font = [UIFont systemFontOfSize:14.0f];
        cell.mA.backgroundColor = [UIColor clearColor];
        cell.mA.textColor = [UIColor blackColor];
        cell.mA.layer.cornerRadius = 0.0f;
        cell.mA.layer.borderColor = [UIColor clearColor].CGColor;
        
        CGRect f = cell.mA.frame;
        f.size.height = [t[4] floatValue]-22.0f;
        cell.mA.frame = f;
        cell.mA.numberOfLines = 0;
        cell.mA.center = CGPointMake( cell.mA.center.x, [t[4] floatValue]/2);
    }
    
    return cell;
}




- (IBAction)callcomp:(id)sender {
    
    if( self.mtagOrder == nil ) return;
    [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
    [self.mtagOrder completeThis:^(SResBase *resb) {
       
        if( resb.msuccess )
        {
            [SVProgressHUD dismiss];
            [self updatePage];
        }
        else
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
    }];
}

- (IBAction)callnav:(id)sender {
    
    if( self.mtagOrder == nil ) return;
    //跳转到高德地图
    NSString* ampurl = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=yz_cm_seller&lat=%.7f&lon=%.7f&dev=0&style=0",[Util getAPPName],self.mtagOrder.mLat,self.mtagOrder.mLongit];
    
    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ampurl]] )
    {//
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ampurl]];
    }
    else
    {//ioS map
        
        CLLocationCoordinate2D to;
        to.latitude =  self.mtagOrder.mLat;
        to.longitude =  self.mtagOrder.mLongit;
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil] ];
        toLocation.name = self.mtagOrder.mAddress;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }
}

- (IBAction)callconfirm:(id)sender {
    if( self.mtagOrder == nil ) return;
    [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
    [self.mtagOrder confirmThis:^(SResBase *resb) {
        
        if( resb.msuccess )
        {
            [SVProgressHUD dismiss];
            [self updatePage];
        }
        else
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
    }];
    
}
-(void)callcancle:(id)sender
{
    
    
    if( self.mtagOrder == nil ) return;
    
    [ReplyView showInVC:self block:^(NSString *text) {
        
         [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
         [self.mtagOrder cancleThis:text block:^(SResBase *resb) {
             
             if( resb.msuccess )
             {
                 [SVProgressHUD dismiss];
                 [self updatePage];
             }
             else
                 [SVProgressHUD showErrorWithStatus:resb.mmsg];
         }];
        
    }];
   
}

- (IBAction)changepeople:(id)sender {
    
    selectPeopleVC* vc = [[selectPeopleVC alloc]init];
    vc.mTagOrder = self.mtagOrder;
    vc.mitblock = ^(int staffid )
    {
        if( -1 != staffid )
        {
            [self updatePage];
        }
    };
    [self pushViewController:vc];
    
}
-(void)callstartsrv:(id)sender
{
    if( self.mtagOrder == nil ) return;
    [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
    [self.mtagOrder startThis:^(SResBase *resb) {
        if( resb.msuccess )
        {
            [SVProgressHUD dismiss];
            [self updatePage];
        }
        else
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
    }];
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
