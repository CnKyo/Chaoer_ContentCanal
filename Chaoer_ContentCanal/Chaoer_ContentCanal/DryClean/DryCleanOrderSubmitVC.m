//
//  DryCleanOrderSubmitVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderSubmitVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DryCleanOrderSubmitTableViewCell.h"
#import "APIClient.h"
#import "UIImage+QUAdditons.h"
#import "DryCleanOrderChooseTimeVC.h"
#import "pptMyAddressViewController.h"
#import "DryCleanOrderChooseCouponTVC.h"
#import "goPayViewController.h"
#import "WPHotspotLabel.h"
#import "QUCustomDefine.h"


typedef enum {
    kChooseYouHuiType_none    = 0,
    kChooseYouHuiType_coupon    = 1,
    kChooseYouHuiType_campaign    = 2,
    kChooseYouHuiType_score    = 3,
} kChooseYouHuiType; //选择优惠类型， 1优惠券 2活动 3积分抵扣

@interface DryCleanOrderSubmitVC ()<UITableViewDelegate,UITableViewDataSource, UIActionSheetDelegate>
@property(nonatomic,strong) NSString*       chooseDateStr;
@property(nonatomic,strong) NSString*       chooseTimeStr;
@property(nonatomic,strong) AddressObject* chooseAddress; //选择的地址
@property(nonatomic,strong) CouponsObject* chooseCoupon; //选择的优惠券
@property(nonatomic,assign) BOOL           chooseScroeToMoney; //是否选择用积分抵扣现金

@property(nonatomic,assign) kChooseYouHuiType chooseYouHuiType;
@property(nonatomic,strong) NSString*       chooseYouHuiNoteStr; //优惠信息
@property(nonatomic,assign) double          chooseYouHuiMoney; //优惠金额

@property(nonatomic,strong) NSString*       chooseCampaignNoteStr; //活动信息
@property(nonatomic,assign) double          chooseCampaignMoney; //活动金额

@property(nonatomic,strong) WPHotspotLabel*       payMoneyLable;
@end

@implementation DryCleanOrderSubmitVC

- (id)init
{
    self = [super init];
    if (self) {
        self.goodsArr = [NSMutableArray array];
        self.chooseScroeToMoney = NO;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"确认订单";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];
    
    if (_showInfoItem.addr != nil)
        self.chooseAddress = _showInfoItem.addr;
    
    [self setCampaignMoney];
    [self reloadUIWithData];
    
}


- (void)initView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    int padding = 10;
    UIView *btnView = ({
        UIView *view = [self.view newUIViewWithBgColor:[UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000]];
        self.payMoneyLable = [[WPHotspotLabel alloc] init];
        [view addSubview:_payMoneyLable];
        UIButton *btn = [self.view newUIButtonWithTarget:self mehotd:@selector(goSubmmitOrderMethod:) title:@"确认订单" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
        [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.157 green:0.749 blue:0.596 alpha:1.000]] forState:UIControlStateNormal];
        [self.payMoneyLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
            make.width.equalTo(view.mas_width).multipliedBy(0.6);
        }];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_payMoneyLable.right).offset(padding);
            make.top.bottom.right.equalTo(view);
        }];
        view;
    });
    [btnView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(btnView.mas_width).multipliedBy(0.14);
    }];
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(64);
        make.bottom.equalTo(btnView.top);
    }];
    

}


-(void)goSubmmitOrderMethod:(id)sender
{
    if (_chooseAddress == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务地址"];
        return;
    }
    
    if (_chooseTimeStr == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务时间"];
        return;
    }
    
    DryClearnShopOrderPostObject *item = [DryClearnShopOrderPostObject new];
    item.shopId = [Util RSAEncryptor:[NSString stringWithFormat:@"%d",_shopId]];
    item.device = @"ios";
    item.userId = [Util RSAEncryptor:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]];
    item.name = _chooseAddress.userName;
    item.mobile = _chooseAddress.phone;
    item.address = _chooseAddress.address;
    item.times = [NSString stringWithFormat:@"%@ %@", _chooseDateStr, _chooseTimeStr];
    item.coupon = [Util RSAEncryptor:[NSString stringWithFormat:@"%d", _chooseCoupon.iD]];
    
    if (_showInfoItem.shop.campaignList.count > 0) {
        DryClearnShopCampaignObject *it = [_showInfoItem.shop.campaignList objectAtIndex:0];
        item.campaing = [Util RSAEncryptor:[NSString stringWithFormat:@"%d", it.iD]];
    } else {
        item.campaing = [Util RSAEncryptor:[NSString stringWithFormat:@"%d", 0]];
    }
    
    BOOL useScore = _chooseYouHuiType == kChooseYouHuiType_score ? YES : NO;
    item.score = [Util RSAEncryptor:[NSString stringWithFormat:@"%d", useScore]];
    
    
    NSMutableArray *arr = [NSMutableArray array];
    for (DryClearnShopServerObject *it in _goodsArr) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:StringWithInt(it.iD),@"classify",  StringWithInt(it.count),@"quantity", nil];
        [arr addObject:dic];
    }
    NSString *cartJson = [arr mj_JSONString];
    item.cartJson = cartJson;
    
    
    [SVProgressHUD showWithStatus:@"处理中..."];
    [[APIClient sharedClient] dryClearnShopOrderSubmmitWithTag:self postItem:item call:^(APIObject *info) {
        if (info.state == RESP_STATUS_YES && item!=nil) {
            goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
            goPay.mMoney = [[info.data objectForKey:@"price"] floatValue];
            goPay.mOrderCode = [info.data objectForKey:@"orderCode"];
            goPay.mType = 4;
            [self pushViewController:goPay];

            
            [SVProgressHUD dismiss];
        } else {
            if (info.message.length > 0)
                [SVProgressHUD showErrorWithStatus:info.message];
        }
    }];
    
    
}

//是否使用积分抵现
-(void) switchAction:(UISwitch *)sender
{
    self.chooseScroeToMoney = sender.on;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)reloadUIWithData
{
    [self setYouHuiMoney];
    
    double money = _showInfoItem.money;
    
    money -= _chooseYouHuiMoney;
    money -= _chooseCampaignMoney;
    
    if (_showInfoItem.shop.freePrice > money)
        money += _showInfoItem.shop.deliverPrice;
    
    if (money < 0)
        money = 0;

    
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};
    self.payMoneyLable.attributedText = [[NSString stringWithFormat:@"实付款:<color>¥%.2f</color> ",money] attributedStringWithStyleBook:mStyle1];
    
    [self.tableView reloadData];
}

-(void)setCampaignMoney
{
    double money = 0;
    NSString *str1 = @"";
    if (_showInfoItem.shop.campaignList.count > 0) {
        DryClearnShopCampaignObject *it = [_showInfoItem.shop.campaignList objectAtIndex:0];
        if ([it.code isEqualToString:@"A"]) { //减去规定金额
            money = it.price;
            str1 = [NSString stringWithFormat:@"活动减免￥%.2f", it.price];
        } else if ([it.code isEqualToString:@"B"]) { //折扣
            money = _showInfoItem.money - _showInfoItem.money * (it.price / 10);
            str1 = [NSString stringWithFormat:@"活动%.2f折", it.price];
        }
        
        if (it.content.length > 0)
            str1 = it.content;
    }

    self.chooseCampaignMoney = money;
    self.chooseCampaignNoteStr = str1.length>0 ? str1 : @"暂无优惠";
}

-(void)setYouHuiMoney
{
    double money = 0;
    NSString *str1 = @"";
    
    switch (_chooseYouHuiType) {
        case kChooseYouHuiType_coupon:
        {
            if ([_chooseCoupon.typeCode isEqualToString:@"A"]) { //减去规定金额
                money = _chooseCoupon.facePrice;
            } else if ([_chooseCoupon.typeCode isEqualToString:@"B"]) { //折扣
                money = _showInfoItem.money - _showInfoItem.money * (_chooseCoupon.facePrice / 10);
            }
            str1 = _chooseCoupon.desc.length>0 ? _chooseCoupon.desc : @"暂无";
            
        }
            break;
        case kChooseYouHuiType_campaign:
        {

        }
            break;
        case kChooseYouHuiType_score:
        {
            str1 = [NSString stringWithFormat:@"共%i积分,可抵用￥%.2f", _showInfoItem.userScore, _showInfoItem.userScore/_showInfoItem.userRate];
            money = (int)(_showInfoItem.userScore/_showInfoItem.userRate);
        }
            break;
        case kChooseYouHuiType_none:
        {
            str1 = @"暂无优惠";
        }
            break;
    }
    self.chooseYouHuiMoney = money;
    self.chooseYouHuiNoteStr = str1.length>0 ? str1 : @"暂无优惠";
}

#pragma mark -- tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    } else if (section == 3) {
        NSInteger count = self.goodsArr.count;
        return count;
    } else if (section == 4) {
        if (_chooseCampaignMoney > 0)
            return 3;
        else
            return 2;
        
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section==1)
        return 60;
    if (indexPath.section == 3)
        return 90;
    return 45;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3)
        return 50;
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        imgView.frame = CGRectMake(10, 10, 30, 30);
        UILabel *lable = [view newUILableWithText:@"重庆超尔科技超市" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        lable.frame = CGRectMake(50, 10, view.bounds.size.width - 60, 30);
        UIView *lineView = [view newUIViewWithBgColor:[UIColor colorWithWhite:0.95 alpha:1]];
        lineView.frame = CGRectMake(0, view.bounds.size.height-1, view.bounds.size.width, 1);
        lable.text = _showInfoItem.shop.shopName.length > 0 ? _showInfoItem.shop.shopName : @"暂无";
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3)
        return 40;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 40)];
        UIView *view = [aView newUIViewWithBgColor:[UIColor whiteColor]];
        view.frame = CGRectMake(0, 0, aView.bounds.size.width, 30);
        UIView *lineView = [view newUIViewWithBgColor:[UIColor colorWithWhite:0.95 alpha:1]];
        lineView.frame = CGRectMake(0, 0, view.bounds.size.width, 1);
        UILabel *lable = [view newUILableWithText:@"应支付:10元" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:QU_TextAlignmentRight];
        lable.frame = CGRectMake(10, 0, view.bounds.size.width - 20, 30);
        
        double money = _showInfoItem.money; //先算优惠券。在计算活动, 再算积分抵扣
        
        lable.text = [NSString stringWithFormat:@"总计:%.2f元", money];
        
        
        return aView;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        static NSString *cellIndentifier = @"DryCleanOrderSubmitVCTableViewCell2";
        DryCleanOrderSubmitTableViewCell *cell = (DryCleanOrderSubmitTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell= [[DryCleanOrderSubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        DryClearnShopServerObject* item = [self.goodsArr objectAtIndex:indexPath.row];
        cell.nameLable.text = item.type.length>0 ? item.type : @"暂无";
        cell.priceLable.text = [NSString stringWithFormat:@"￥%.2f", item.price];
        cell.countLable.text = [NSString stringWithFormat:@"共%i件", item.count];
        [cell.thumbImgView setImageWithURL:[NSURL imageurl:item.image] placeholderImage:IMG(@"DefaultImg.png")];
        
        return cell;
        
    } else {
        static NSString *cellIndentifier = @"DryCleanOrderSubmitVCTableViewCell1";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.text = 0;
        }
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"dryClean_address_choose.png");
            
            NSString *str = nil;
            if (_chooseAddress.address.length > 0) {
                str = [NSString stringWithFormat:@"%@", _chooseAddress.address];
            } else
                str = @"请选择服务地址";
            cell.textLabel.text = str;
            
        } else if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = IMG(@"dryClean_time_choose.png");
            cell.textLabel.text = _chooseTimeStr.length>0 ? _chooseTimeStr : @"请选择服务时间";
            
        } else if (indexPath.section == 2) {
            cell.imageView.image = nil;
            
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"优惠类型";
                switch (_chooseYouHuiType) {
                    case kChooseYouHuiType_coupon:
                        cell.detailTextLabel.text = @"优惠券";
                        break;
//                    case kChooseYouHuiType_campaign:
//                        cell.detailTextLabel.text = @"活动";
                        break;
                    case kChooseYouHuiType_score:
                        cell.detailTextLabel.text = @"积分抵扣";
                        break;
                    case kChooseYouHuiType_none:
                        cell.detailTextLabel.text = @"未选择优惠方式";
                        break;
                    default:
                        break;
                }
            } else if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textColor = [UIColor colorWithRed:0.875 green:0.518 blue:0.086 alpha:1.000];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.882 green:0.157 blue:0.200 alpha:1.000];
                
                cell.textLabel.text = _chooseYouHuiNoteStr;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"-￥%.2f", _chooseYouHuiMoney];
            }
            
            
        } else if (indexPath.section == 4) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.882 green:0.157 blue:0.200 alpha:1.000];
            
            double money = 0;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"总金额";
                money = _showInfoItem.money;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", money];
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"服务费";
                
                if (_showInfoItem.shop.freePrice > (_showInfoItem.money - _chooseYouHuiMoney - _chooseCampaignMoney))
                    money = _showInfoItem.shop.deliverPrice;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"+￥%.2f", money];
                
            } else if (indexPath.row == 2) {
                cell.textLabel.text = _chooseCampaignNoteStr;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"-￥%.2f", _chooseCampaignMoney];
            }
            
        }
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
        ppt.mType = 1;
        ppt.blockGPPTaddress = ^(GPPTaddress *item){
            self.chooseAddress = [AddressObject new];
            self.chooseAddress.iD = item.mId;
            self.chooseAddress.userName = item.mUserName;
            self.chooseAddress.address = [NSString stringWithFormat:@"%@%@", item.mAddress, item.mDetailsAddr];
            self.chooseAddress.phone = item.mPhone;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self pushViewController:ppt];
        
    } else if (indexPath.section == 1) {
        DryCleanOrderChooseTimeVC *vc = [[DryCleanOrderChooseTimeVC alloc] init];
        vc.shopId = _shopId;
        vc.hiddenTabBar = YES;
        vc.chooseCallBack = ^(NSString* dateStr, NSString* timeStr) {
            self.chooseDateStr = dateStr;
            self.chooseTimeStr = timeStr;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"优惠券", @"积分抵扣", nil];
            ac.tag = 1001;
            [ac showInView:[self.view window]];
        }
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (_showInfoItem.coupons.count > 0) {
            self.chooseYouHuiType = kChooseYouHuiType_coupon;
            
            DryCleanOrderChooseCouponTVC *vc = [[DryCleanOrderChooseCouponTVC alloc] init];
            vc.tableArr = _showInfoItem.coupons;
            vc.hiddenTabBar = YES;
            vc.chooseCallBack = ^(CouponsObject* item) {
                self.chooseCoupon = item;
                [self reloadUIWithData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else
            [SVProgressHUD showErrorWithStatus:@"暂无优惠券"];
        
    }
//    else if (buttonIndex == 2) {
//        if (_showInfoItem.shop.campaignList.count > 0) {
//            self.chooseYouHuiType = kChooseYouHuiType_campaign;
//            [self reloadUIWithData];
//        } else
//            [SVProgressHUD showErrorWithStatus:@"暂无活动优惠"];
//    }
    else if (buttonIndex == 1) {
        if (_showInfoItem.userScore > 0) {
            self.chooseYouHuiType = kChooseYouHuiType_score;
            [self reloadUIWithData];
        } else
            [SVProgressHUD showErrorWithStatus:@"用户积分为0"];
    }
    
    
}


@end
