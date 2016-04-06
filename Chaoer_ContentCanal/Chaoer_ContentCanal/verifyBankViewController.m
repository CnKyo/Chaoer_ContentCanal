//
//  verifyBankViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "verifyBankViewController.h"
#import "needCodeView.h"
#import "MHActionSheet.h"
@interface verifyBankViewController ()

@end

@implementation verifyBankViewController
{
    UIScrollView *mScrollerView;
    
    needCodeView    *mView;
    
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
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initview];
}
- (void)initview{
    
    UIImageView *iii = [UIImageView new];
    
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [needCodeView shareVerifyBankView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    [mView.mBankBtn addTarget:self action:@selector(bankNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mProvinceBtn addTarget:self action:@selector(provinceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mChoiseCityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBankPointBtn addTarget:self action:@selector(pointAction:) forControlEvents:UIControlEventTouchUpInside];
    
     [mView.mVerifyBtn addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)bankNameAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择城市" style:MHSheetStyleWeiChat itemTitles:@[@"重庆",@"成都",@"西安",@"贵阳",@"长沙",@"广州",@"福州",@"淄博",@"郴州"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"%@", title];
        mView.mBankLb.text = text;
    }];
    
    
    
}
- (void)provinceAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择城市" style:MHSheetStyleWeiChat itemTitles:@[@"重庆",@"成都",@"西安",@"贵阳",@"长沙",@"广州",@"福州",@"淄博",@"郴州"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"%@", title];
        mView.mProvinceLb.text = text;
    }];
    
    
    
}
- (void)cityAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择城市" style:MHSheetStyleWeiChat itemTitles:@[@"重庆",@"成都",@"西安",@"贵阳",@"长沙",@"广州",@"福州",@"淄博",@"郴州"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"%@", title];
        mView.mChoiseCity.text = text;
    }];
    
    
    
}
- (void)pointAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择城市" style:MHSheetStyleWeiChat itemTitles:@[@"重庆",@"成都",@"西安",@"贵阳",@"长沙",@"广州",@"福州",@"淄博",@"郴州"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"%@", title];
        mView.mBankPointLb.text = text;
    }];
    
    
    
}

- (void)verifyAction:(UIButton *)sneder{
    if (mView.mBankName.text.length == 0) {
        [mView.mBankName becomeFirstResponder];
        [self showErrorStatus:@"请输入您的真实姓名"];
        return;
    }
    if (mView.mBankIdentify.text.length == 0) {
        [mView.mBankIdentify becomeFirstResponder];
        [self showErrorStatus:@"身份证不能为空"];
        return;
    }
    if (mView.mBanCardTx.text.length == 0) {
        [self showErrorStatus:@"银行卡不能为空"];
        [mView.mBanCardTx becomeFirstResponder];

        return;
    }
    if (![Util checkIdentityCardNo:mView.mBankIdentify.text]) {
        [mView.mBankIdentify becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的身份证号码"];
        return;
    }
    if (![Util checkBankCard:mView.mBanCardTx.text]) {
        [mView.mBanCardTx becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的银行卡号"];
        return;
    }
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
