//
//  depositViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "depositViewController.h"
#import "pptStatusViewController.h"
#import "mBalanceViewController.h"

@interface depositViewController ()
@property (weak, nonatomic) IBOutlet UIView *mView;
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@end

@implementation depositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"申请跑跑腿";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    
    self.mView.layer.masksToBounds = YES;
    self.mView.layer.cornerRadius = self.mView.mwidth/2;
    
    self.mOkBtn.layer.masksToBounds = YES;
    self.mOkBtn.layer.cornerRadius = 3;
    
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
- (IBAction)mOkAction:(id)sender {
    
    [self AlertViewShow:@"确定提交" alertViewMsg:@"提交即会扣除“100元”押金！" alertViewCancelBtnTiele:@"取消" alertTag:10];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        if( buttonIndex == 1)
        {
            
            if ([mUserInfo backNowUser].mMoney < 100) {
                
                [self AlertViewShow:@"提交失败" alertViewMsg:@"您的余额不足！请充值！" alertViewCancelBtnTiele:@"取消" alertTag:11];
                
                return;
            }else{
                [self showErrorStatus:@"正在提交...."];
                [[mUserInfo backNowUser] payPPTAplly:^(mBaseData *resb) {
                    if (resb.mSucess) {
                        [self dismiss];
                        
                        pptStatusViewController *ppp = [[pptStatusViewController alloc] initWithNibName:@"pptStatusViewController" bundle:nil];
                        [self pushViewController:ppp];
                        
                    }else{
                        [self showErrorStatus:resb.mMessage];
                    }
                }];
                
            }
            
            
        }

    }else{
        if( buttonIndex == 1)
        {
            mBalanceViewController *mmm = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
            [self pushViewController:mmm];
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
