//
//  WithDrawVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "WithDrawVC.h"
#import "BillRecordVC.h"

@interface WithDrawVC ()

@end

@implementation WithDrawVC

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
    self.Title = self.mPageName = @"我要提现";
    self.rightBtnTitle = @"提现纪录";
    [self.navBar.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-80, self.navBar.leftBtn.origin.y, 100, self.navBar.leftBtn.mheight);
    _mTiXian.layer.cornerRadius = 5;
//    _mPrice.text = [NSString stringWithFormat:@"¥%.2f",_mShop.mBalance];
    
    [self loadData];
}

- (void)leftBtnTouched:(id)sender{

    if (_itblock) {
        _itblock(YES);
    }
    
    [self popViewController];
}

- (void)rightBtnTouched:(id)sender{

    BillRecordVC *record = [[BillRecordVC alloc] init];
//    record.mShop = _mShop;
    [self pushViewController:record];
}

- (void)loadData{
    
//    _mBank.text = _mDrawInfo.mBankName;
//    _mName.text = _mDrawInfo.mName;
//    _mNum.text = _mDrawInfo.mBankNo;
//    
//    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_mDrawInfo.mNotice dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    _mRemark.attributedText = attrStr;
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

- (IBAction)AllClick:(id)sender {
    
//    if(_mShop.mBalance<=0){
//    
//        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有可提现金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alt show];
//        
//        return;
//
//    }
//    _mPriceTF.text = [NSString stringWithFormat:@"%.2f",_mShop.mBalance];
//    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//    [[SUser currentUser] getWithDraw:_mShop.mBalance block:^(SResBase *resb) {
//        
//        if (resb.msuccess) {
//            
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];
}

- (IBAction)mTiXianClick:(id)sender {
    
    if(_mPriceTF.text.length == 0){
    
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入提现金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alt show];
        
        return;
    
    }
    
//    if (![Util checkNum:_mPriceTF.text] || [_mPriceTF.text floatValue]<=0 || [_mPriceTF.text floatValue]>_mShop.mBalance) {
//        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的提现金额有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alt show];
//        
//        return;
//    }
    
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//    [[SUser currentUser] getWithDraw:[_mPriceTF.text floatValue] block:^(SResBase *resb) {
//        
//        if (resb.msuccess) {
//            
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            [self popViewController];
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];

    
}
@end
