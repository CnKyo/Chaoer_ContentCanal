//
//  AddBankInfo.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/12/11.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "AddBankInfo.h"
#import "MZTimerLabel.h"

@interface AddBankInfo ()<MZTimerLabelDelegate>{
    
    UILabel *timer_show;//倒计时label
}

@end

@implementation AddBankInfo

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
    // Do any additional setup after loading the view.
    
    self.mPageName = @"添加银行卡";
    
    self.Title = self.mPageName;
    
    NSRange range = {3,4};
    
    
//    NSString *string = [[SUser currentUser].mPhone stringByReplacingCharactersInRange:range withString:@"****"];
//
//    _mDetailText.text = [NSString stringWithFormat:@"验证码发送至你绑定的手机号%@",string];
//    _mName.text = _mShopInfo.mContacts;
////    _mName.text = @"赵三";
//    _mName.enabled = NO;
//    if (_mDraw) {
//        
//        _mBankname.text = _mDraw.mBank;
//        _mBankNo.text = _mDraw.mBankNo;
//        
//    }
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

- (IBAction)mGetCodeClick:(id)sender {

//    [SUser sendSM:[SUser currentUser].mPhone block:^(SResBase *resb) {
//        if (resb.msuccess) {
//            [self timeCount];
//            [sender setBackgroundImage:[UIImage imageNamed:@"huibutton"] forState:0];
//            
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            _mCodeBT.userInteractionEnabled = YES;
//            [sender setBackgroundImage:[UIImage imageNamed:@"17-1"] forState:0];
//            
//        }
//    }];
}

- (void)timeCount{//倒计时函数
    
    [_mCodeBT setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mCodeBT.frame.size.width, _mCodeBT.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [_mCodeBT addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    _mCodeBT.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [_mCodeBT setTitle:@"重发验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    _mCodeBT.userInteractionEnabled = YES;//按钮可以点击
    [_mCodeBT setBackgroundImage:[UIImage imageNamed:@"17-1"] forState:0];
    
}

- (IBAction)mSubmitClick:(id)sender {
    
    if (_mName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    if (_mBankname.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入开户行全称"];
        return;
    }
    if (_mBankNo.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入开户行账号"];
        return;
    }
    if (_mCode.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
//    if (_mDraw) {
//        
//        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//        [_mDraw EditBank:_mBankname.text bankNo:_mBankNo.text mobile:[SUser currentUser].mPhone name:_mName.text verifyCode:_mCode.text block:^(SResBase *resb, SWithDrawInfo *draw) {
//            
//            if (resb.msuccess) {
//                [SVProgressHUD dismiss];
//                [self popViewController];
//            }else{
//                
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//            
//        }];
//        
//        return;
//    }
//    
//    [SWithDrawInfo AddBank:_mBankname.text bankNo:_mBankNo.text mobile:[SUser currentUser].mPhone name:_mName.text verifyCode:_mCode.text block:^(SResBase *resb, SWithDrawInfo *draw) {
//        
//        if (resb.msuccess) {
//            [self popViewController];
//        }else{
//        
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        
//    }];
    
}
@end
