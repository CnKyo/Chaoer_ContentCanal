//
//  mFeedPersonViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedPersonViewController.h"
#import "MHActionSheet.h"
@interface mFeedPersonViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation mFeedPersonViewController
{
    /**
     *  1是小区 2是楼栋
     */
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
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"投诉居民";
    
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.84 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 1;
    
    self.mReason.placeholder = @"在此写上您投诉的原因:";
    [self.mReason setHolderToTop];
//    [self initTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{

    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];

    [[mUserInfo backNowUser] getArear:^(mBaseData *resb, NSArray *mArr) {
        
        [SVProgressHUD dismiss];
        [self.tempArray removeAllObjects];
        
        if (resb.mSucess) {
        
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            for (GArear *mArear in mArr) {
                [self.tempArray addObject:mArear.mAddress];
            }
            [self loadMHActionSheetView];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
}


- (void)loadMHActionSheetView{
    
    NSString *mTiele = nil;
    
    if (mType == 1) {
        mTiele = @"请选择小区";
    }else{
        mTiele = @"请选择楼栋";
    }
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:mTiele style:MHSheetStyleWeiChat itemTitles:self.tempArray];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
//        [sender setTitle:text forState:UIControlStateSelected];
        
    }];

}

#pragma mark----提交按钮
- (IBAction)mSubmitAction:(id)sender {


    
}
#pragma mark----小区
- (IBAction)mValiigeAction:(UIButton *)sender {
    mType = 1;
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self loadData];
        
    }else{
        sender.selected = NO;
    }


}
#pragma mark----楼栋
- (IBAction)mBuildAction:(UIButton *)sender {
    mType = 2;

    sender.selected = !sender.selected;
//    [self showBuildView:sender.selected];
    if (sender.selected) {
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择小区" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
        actionSheet.cancleTitle = @"取消选择";
        
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
            [sender setTitle:text forState:UIControlStateSelected];
            
        }];
        
    }else{
        sender.selected = NO;
    }

}
#pragma mark----门牌号
- (IBAction)mDoorAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    //    [self showDoorNumView:sender.selected];
    if (sender.selected) {
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择小区" style:MHSheetStyleWeiChat itemTitles:@[@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"头等舱",@"商务舱",@"经济舱",@"特等座",@"一等座",@"二等座",@"软座",@"硬座",@"不限"]];
        actionSheet.cancleTitle = @"取消选择";
        
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
            [sender setTitle:text forState:UIControlStateSelected];
            
        }];
        
    }else{
        sender.selected = NO;
    }
}


- (void)showValigeView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mValiigeH.constant = 200;
            
        }else{
            self.mValiigeH.constant = 0;
            
        }
        
        self.mBuildH.constant = 0;
        self.mDoorNumH.constant = 0;
        
        
    }];
}
- (void)showBuildView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mBuildH.constant = 200;
            
        }else{
            self.mBuildH.constant = 0;
            
        }
        self.mValiigeH.constant = 0;
        self.mDoorNumH.constant = 0;
        
    }];
}
- (void)showDoorNumView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mDoorNumH.constant = 150;
            
        }else{
            self.mDoorNumH.constant = 0;
            
        }
        self.mValiigeH.constant = 0;
        self.mBuildH.constant = 0;
        
    }];
}
- (void)hiddenView:(UITableView *)mTT{
    if (mTT == self.mValiigeTableView) {
        self.mValiigeH.constant = 0;
        self.mValiigeBtn.selected = YES;

    }if (mTT == self.mBuildTableView) {
        self.mBuildH.constant = 0;

    }else{
        self.mDoorNumH.constant = 0;

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
//-(void)initTap{
//    
//    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mTapAction)];
//    [self.view addGestureRecognizer:ttt];
//}
//- (void)mTapAction{
//    [self.mReason resignFirstResponder];
//}


#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == self.mValiigeTableView) {
        return 10;
    }if (tableView == self.mBuildTableView) {
        return 10;
    }else{
        return 5;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    if (tableView == self.mValiigeTableView) {
        
        [self.mValiigeBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mValiigeTableView];
    }if (tableView == self.mBuildTableView) {
        [self.mBuildBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mBuildTableView];

    }else{
        [self.mDoorNumBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mDoorNumTableView];

    }
    
    NSLog(@"第%ld行",(long)indexPath.row);
    
}

@end
