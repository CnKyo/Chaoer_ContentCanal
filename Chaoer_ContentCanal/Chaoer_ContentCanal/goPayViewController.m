//
//  goPayViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "goPayViewController.h"
#import "QUCustomDefine.h"

@interface goPayViewController ()
/**
 *  余额
 */
@property (weak, nonatomic) IBOutlet UILabel *mBalance;
/**
 *  余额充值按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBalanceBtn;
/**
 *  支付金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPayMoney;
/**
 *  微信图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mWechatImg;
/**
 *  支付宝图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mAliImg;
/**
 *  银行卡图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBankImg;
/**
 *  余额图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBalanceImg;
/**
 *  微信支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoWeChatBtn;
/**
 *  支付宝支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoAliPayBtn;
/**
 *  银行卡支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoBankBtn;
/**
 *  余额支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoBalanceBtn;
/**
 *  去支付
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;


@end

@implementation goPayViewController
{

    NSMutableArray *mSelectArr;
}
@synthesize mType,mMoney,mOrderCode;

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"支付订单";
    mSelectArr = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.mGoPayBtn.layer.masksToBounds = self.mBalanceBtn.layer.masksToBounds = YES;
    self.mGoPayBtn.layer.cornerRadius = self.mBalanceBtn.layer.cornerRadius = 3;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUserPaySuccess:)
                                                 name:MyOrderPaySuccessNotification
                                               object:nil];
    
    self.mBalance.text = [NSString stringWithFormat:@"余额:%.2f元",[mUserInfo backNowUser].mMoney];
    self.mPayMoney.text = [NSString stringWithFormat:@"¥%.2f元",mMoney];
}


-(void)handleUserPaySuccess:(NSNotification *)note
{
    [self popVCWithPaySuccess];
}


#pragma mark----去充值
- (IBAction)mGoBalanceAction:(UIButton *)sender {
    mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:ppp];
}
#pragma mark----选择支付方式
- (IBAction)mSelectePayType:(UIButton *)sender {
    [mSelectArr removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                self.mGoWeChatBtn.selected = YES;
                self.mGoAliPayBtn.selected = NO;
                self.mGoBankBtn.selected = NO;
                self.mGoBalanceBtn.selected = NO;

                [mSelectArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mSelectArr removeObject:NumberWithFloat(sender.tag)];
                
            }

        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                self.mGoWeChatBtn.selected = NO;
                self.mGoAliPayBtn.selected = YES;
                self.mGoBankBtn.selected = NO;
                self.mGoBalanceBtn.selected = NO;
                
                [mSelectArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mSelectArr removeObject:NumberWithFloat(sender.tag)];
                
            }
        }
            break;
        case 3:
        {
            if (mType == 2) {
                [self showErrorStatus:@"暂不支持此支付方式！"];
                return;
                
            }else{
                if (sender.selected == NO) {
                    self.mGoWeChatBtn.selected = NO;
                    self.mGoAliPayBtn.selected = NO;
                    self.mGoBankBtn.selected = YES;
                    self.mGoBalanceBtn.selected = NO;
                    
                    [mSelectArr addObject:NumberWithFloat(sender.tag)];
                }else{
                    sender.selected = NO;
                    [mSelectArr removeObject:NumberWithFloat(sender.tag)];
                    
                }
            }
        }
            break;
        case 4:
        {
            
            
            if (sender.selected == NO) {
                self.mGoWeChatBtn.selected = NO;
                self.mGoAliPayBtn.selected = NO;
                self.mGoBankBtn.selected = NO;
                self.mGoBalanceBtn.selected = YES;
                
                [mSelectArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mSelectArr removeObject:NumberWithFloat(sender.tag)];
                
            }
            
            
            
        }
            break;
        default:
            break;
    }
}
#pragma mark----去支付
- (IBAction)mGoPayAction:(UIButton *)sender {
    MLLog(@"选择了什么方式支付：%@",mSelectArr);
 
    if (mSelectArr.count<=0) {
        [self showErrorStatus:@"请选择充值类型！"];
        return;
        
    }

    
    int type = [[NSString stringWithFormat:@"%@",mSelectArr[0]] intValue];
    
    if (type == 3) {
        [self showErrorStatus:@"不支持的充值类型！"];
        return;
    }else if(type == 4){
        
        if ([mUserInfo backNowUser].mMoney < mMoney) {
            [self showErrorStatus:@"余额不足支付失败！"];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"正在操作..." maskType:SVProgressHUDMaskTypeClear];
      
        [[mUserInfo backNowUser] payType:type andType:mType andPrice:mMoney andCode:mOrderCode block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                
                [self popVCWithPaySuccess];
                
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
        

        
    }else{
        [SVProgressHUD showWithStatus:@"正在操作..." maskType:SVProgressHUDMaskTypeClear];
    
        [[mUserInfo backNowUser] payType:type andType:mType andPrice:mMoney andCode:mOrderCode block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];

                [self popVCWithPaySuccess];
//                if (mType == 1) {
//                    [self popViewController:4];
//                }else{
//                    [self popViewController];
//                    
//                }
                
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
        
 
    }

}

-(void)popVCWithPaySuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil]; //需要刷新用户数据
    
    if (_mIsPushFromOrderVC == YES) {
        [self popViewController];
    } else {
        if (mType == 1) {
            [self popViewController:4];
        } else if (mType == 4) {
            
            [self popViewController_2];
            
        } else{
            [self popViewController];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)leftBtnTouched:(id)sender{

    [self AlertViewShow:@"订单已生成确认要离开吗？" alertViewMsg:@"离开这里将重新下单！" alertViewCancelBtnTiele:@"取消" alertTag:10];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 1)
    {
        if (_mIsPushFromOrderVC == YES) {
            [self popViewController];
        } else {
            if (mType == 1) {
                
                [self popViewController_2];
            } else if (mType == 4) {
                
                [self popViewController_2];
                
            } else{
                [self popViewController];
            }
        }

        
    }
  }

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
@end
