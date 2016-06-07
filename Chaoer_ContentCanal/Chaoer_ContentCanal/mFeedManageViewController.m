//
//  mFeedManageViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedManageViewController.h"
#import "utilityView.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
#import "hasCodeViewController.h"
@interface mFeedManageViewController ()

@end

@implementation mFeedManageViewController
{
    int mid;

    utilityView *mView;

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
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}

- (void)loadData{

    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] getArear:^(mBaseData *resb, NSArray *mArr) {
        [SVProgressHUD dismiss];
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self.tempArray addObjectsFromArray:mArr];
            [self loadActionView];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self initEmptyView];
            
            [self AlertViewShow:@"您还没有添加小区！" alertViewMsg:@"添加小区后才能投诉哦！" alertViewCancelBtnTiele:@"取消" alertTag:10];

        }

    }];
}


- (void)initEmptyView{
    
    mView = [utilityView shareEmpty];
    mView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    
    [self.view addSubview:mView];
    
    
}
- (void)loadActionView{
    
    NSMutableArray *mar = [NSMutableArray new];
    [mar removeAllObjects];
    for ( GArear *dic in self.tempArray) {
        [mar addObject:dic.mAddress];
    }
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"请选择小区" style:MHSheetStyleWeiChat itemTitles:mar];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {

        self.mArearLb.text = title;
        GArear *mAraer = self.tempArray[index];
        mid = mAraer.mId;
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"投诉管理者";
    mid = 0;
    self.mReason.placeholder = @"请输入您要投诉的原因 。";
    [self.mReason setHolderToTop];
    self.mBgtkView.layer.masksToBounds = YES;
    self.mBgtkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.84 alpha:1].CGColor;
    self.mBgtkView.layer.borderWidth = 1;
    
    self.mSubmitBtn.layer.masksToBounds = YES;
    self.mSubmitBtn.layer.cornerRadius = 3;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}

- (IBAction)mVallige:(UIButton *)sender {
    [self loadData];

}

#pragma mark----提交按钮
- (IBAction)okAction:(id)sender {
    if (mid == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择您要投诉的小区！"];
        return;
    }
    if (self.mName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入被投诉的人！"];
        return;
    }if (self.mReason.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要投诉的内容！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo feedCanal:mid andName:self.mName.text andReason:self.mReason.text block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 0)
    {
        [self popViewController];
    }else{
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 1;
        nnn.mPageName = @"添加房屋";
        [self pushViewController:nnn];
        
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去添加", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
