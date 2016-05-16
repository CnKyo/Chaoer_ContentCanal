//
//  pptAddAddressViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptAddAddressViewController.h"

#import "AddressPickView.h"
@interface pptAddAddressViewController ()<UITextFieldDelegate>

@end

@implementation pptAddAddressViewController
{

    NSMutableArray *mSexArr;
    
    AddressPickView *addressPickView;
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
    self.Title = self.mPageName = @"添加地址";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    
    mSexArr = [NSMutableArray new];
    
    self.mSaveBtn.layer.masksToBounds = YES;
    self.mSaveBtn.layer.cornerRadius = 3;
    
    
    self.mPhoneTx.delegate = self;
    
    
}
#pragma mark----选择性别
- (IBAction)mChoiceSexAction:(UIButton *)sender {
    [mSexArr removeAllObjects];
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                self.mManBtn.selected = YES;
                self.mWomenBtn.selected = NO;
                [mSexArr addObject:NumberWithInt(1)];
                
            }else{
                sender.selected = NO;
                [mSexArr removeObject:NumberWithInt(1)];
                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                self.mManBtn.selected = NO;
                self.mWomenBtn.selected = YES;
                [mSexArr addObject:NumberWithInt(2)];
                
            }else{
                sender.selected = NO;
                [mSexArr removeObject:NumberWithInt(2)];
                
            }
        }
            break;
            
        default:
            break;
    }

}


#pragma mark----选择地址按钮
- (IBAction)mChoiceAddressAction:(UIButton *)sender {
    
 
    [self loadAddressPick];
    
}
- (void)loadAddressPick{
    [addressPickView removeFromSuperview];
    
    addressPickView  = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    
    __weak __typeof(self)weakSelf = self;
    
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        
        weakSelf.mAddressLb.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town ];
        
    };
}
#pragma mark----选择标签按钮
- (IBAction)mTagAction:(UIButton *)sender {
    
    [self loadTag];

    
}
- (void)loadTag{
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择标签" style:MHSheetStyleWeiChat itemTitles:@[@"请闹",@"速度",@"阳光",@"美女"]];
    actionSheet.cancleTitle = @"取消选择";
    __weak __typeof(self)weakSelf = self;

    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSLog(@"选择了%@",title);
        [weakSelf.mTagBtn setTitle:title forState:0];
    }];
}
#pragma mark----保存按钮
- (IBAction)mSaveAction:(UIButton *)sender {
    
    if (self.mNameTx.text.length == 0) {
        [LCProgressHUD showFailure:@"姓名不能为空！"];
        [self.mNameTx becomeFirstResponder];
        return;
    }if (!mSexArr.count) {
        [LCProgressHUD showInfoMsg:@"请选择您的性别"];
        return;
    }if (self.mPhoneTx.text.length == 0) {
        [LCProgressHUD showFailure:@"联系电话不能为空！"];
        [self.mPhoneTx becomeFirstResponder];
        return;
    }if(![Util isMobileNumber:self.mPhoneTx.text]){
        [LCProgressHUD showInfoMsg:@"请输入合法的手机号码"];
        [self.mPhoneTx becomeFirstResponder];
        return;
    }if ([self.mAddressLb.text isEqualToString:@"请选择地址"]) {
        [LCProgressHUD showFailure:@"请选择地址！"];
        [self loadAddressPick];
        return;
    }if (self.mAddressDetailTx.text.length == 0) {
        [LCProgressHUD showFailure:@"请完善您的详细地址！"];
        [self.mAddressDetailTx becomeFirstResponder];
        return;
    }if ([self.mTagBtn.titleLabel.text isEqualToString:@"请选择标签"]) {
        [LCProgressHUD showFailure:@"请选择标签！"];
        [self loadTag];
        return;
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

@end