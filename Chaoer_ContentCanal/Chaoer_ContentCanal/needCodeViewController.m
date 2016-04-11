//
//  needCodeViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "needCodeViewController.h"
#import "needCodeView.h"
#import "MHActionSheet.h"

#import "verifyBankViewController.h"
@interface needCodeViewController ()

@end

@implementation needCodeViewController
{
    UIScrollView *mScrollerView;
    
    needCodeView    *mView;
    
    int mCityId;
    
    int mArearId;
    
    int mType;
    
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    mType = 1;
    
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
    
    
    mView = [needCodeView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    [mView.mCityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mArearBtn addTarget:self action:@selector(arearAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCanalBtn addTarget:self action:@selector(canalAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCommunityBtn addTarget:self action:@selector(communityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mDoorNuimBtn addTarget:self action:@selector(doornumAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBuildBtn addTarget:self action:@selector(builAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mMasterBtn addTarget:self action:@selector(choiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mVisitorBtn addTarget:self action:@selector(choiseAction:) forControlEvents:UIControlEventTouchUpInside];



    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
}


- (void)loadData{

    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    if (mType == 3) {
        
        [mUserInfo getArearId:mArearId andProvince:mCityId block:^(mBaseData *resb) {
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];

            }
        }];
        
    }else{
        [mUserInfo getCityId:mCityId block:^(mBaseData *resb, NSArray *mArr) {
            [SVProgressHUD dismiss];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                [self.tempArray addObjectsFromArray:mArr];
                [self loadMHActionSheetView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
            
        }];
    }
    
    
}

- (void)loadMHActionSheetView{
    
    NSString *mTt = nil;
    
    if (mType == 1) {
        mTt = @"选择城市";
    }else if (mType == 2){
    
        mTt = @"选择市区";
    }else{
        mTt = @"选择物管公司";
    }
    
    
    NSMutableArray  *Arrtemp = [NSMutableArray new];
    
    for (GCity *city in self.tempArray) {
        [Arrtemp addObject:city.mAreaName];
    }

    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:mTt style:MHSheetStyleWeiChat itemTitles:Arrtemp];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        GCity *city = self.tempArray[index];
        
        NSString *text = [NSString stringWithFormat:@"%@", city.mAreaName];
        mCityId = [[NSString stringWithFormat:@"%@",city.mAreaId] intValue];
        
        if (mType == 1) {
            mView.mCityLb.text = text;
        }else if (mType == 2){
            
            mView.mArearLb.text = text;
            mArearId = [[NSString stringWithFormat:@"%@",city.mParentId] intValue];

        }else{
            mView.mCanalLb.text = text;
        }
        
        
    }];
}
- (void)cityAction:(UIButton *)sender{
    if (mView.mNameTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的名称！"];
        [mView.mNameTx becomeFirstResponder];
        return;
    }
    sender.selected = !sender.selected;
    mType = 1;
    mCityId = 0;
    [self loadData];

}
- (void)arearAction:(UIButton *)sender{
    if (mCityId == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 2;
    [self loadData];



}
- (void)canalAction:(UIButton *)sender{
    if (mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择区县!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 3;
    [self loadData];

}
- (void)communityAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择小区" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        mView.mCommunityLb.text = text;

    }];
    
 

}
- (void)doornumAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择楼栋号" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        mView.mDoorNumLb.text = text;
        
    }];


}
- (void)builAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择门牌号" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        mView.mBuildLb.text = text;
        
    }];
    


}
- (void)okAction:(UIButton *)sender{
    verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
    [self pushViewController:vvv];
}

- (void)choiseAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = YES;
                mView.mVisitorBtn.selected = NO;
            }else{
                sender.selected = NO;
                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = NO;
                mView.mVisitorBtn.selected = YES;
            }else{
                sender.selected = NO;
                
            }
        }
            break;
  
        default:
            break;
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
