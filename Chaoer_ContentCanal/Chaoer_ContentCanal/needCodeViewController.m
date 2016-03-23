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

@interface needCodeViewController ()

@end

@implementation needCodeViewController
{
    UIScrollView *mScrollerView;
    
    needCodeView    *mView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initview];
}
- (void)initview{
    
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

- (void)cityAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择城市" style:MHSheetStyleWeiChat itemTitles:@[@"重庆",@"成都",@"西安",@"贵阳",@"长沙",@"广州",@"福州",@"淄博",@"郴州"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"%@", title];
        mView.mCityLb.text = text;
    }];
    
 

}
- (void)arearAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择市区" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        mView.mArearLb.text = text;
        
    }];
    


}
- (void)canalAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择物管公司" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        mView.mCanalLb.text = text;
        
    }];


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
