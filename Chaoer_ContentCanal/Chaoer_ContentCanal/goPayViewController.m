//
//  goPayViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "goPayViewController.h"

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
    
    
}
#pragma mark----去充值
- (IBAction)mGoBalanceAction:(UIButton *)sender {

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

@end
