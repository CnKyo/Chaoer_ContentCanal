//
//  mFixViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixViewController.h"

#import "fixTableViewCell.h"

#import "choiseServicerViewController.h"

#import "RSKImageCropper.h"

#import "addAddressViewController.h"
#import "TFFileUploadManager.h"
#import "needCodeViewController.h"
#import "MHDatePicker.h"


#import "comfirOrderViewController.h"

#import "FixNewCell.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@interface mFixViewController ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,HZQDatePickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,THHHTTPDelegate,UITableViewDelegate,UITableViewDataSource>{
    HZQDatePickerView *_pikerView;

}


@end

@implementation mFixViewController
{

    
    
    NSArray *mImageArr;
    
    NSArray *mTTArr;
    
}
@synthesize sType,mSuperID,mTT;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WJStatusBarHUD hide];
  
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

    if (mTT.length == 0) {
        mTT = @"物业报修";
    }else{
    
    }
    
    self.Title = self.mPageName = mTT;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;


    [self initWithView];
    
}
- (void)initWithView{

    mImageArr = @[[UIImage imageNamed:@"fix_pipeline"],[UIImage imageNamed:@"fix_clean"],[UIImage imageNamed:@"fix_ appliance"]];
    mTTArr =  @[@"管道类",@"清洁类",@"家电类"];
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    
    if (sType == 2) {
        self.tableView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.45];
    }else{
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    if (sType == 2) {
        self.haveHeader = YES;
    }else{
    
    }

    UINib   *nib = [UINib nibWithNibName:@"FixNewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"mFixRestCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

}
- (void)headerBeganRefresh{
    
    [mUserInfo getFixDetail:mSuperID andLevel:@"2" block:^(mBaseData *resb, NSArray *marr) {
        [self headerEndRefresh];
        
        [self.tempArray removeAllObjects];
        [self.tableView reloadData];
        if (resb.mSucess) {
            [self.tempArray addObjectsFromArray:marr];
            [self.tableView reloadData];
            
        }else{
            [LCProgressHUD showFailure:@"数据加载错误!"];
            
        }
    }];
    
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (sType == 2) {
        
        return self.tempArray.count%2==0?self.tempArray.count/2:self.tempArray.count/2+1;
        
    }else{
        return mImageArr.count;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sType == 2) {
        return 195;
    }else{
        return 150;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;

    
    if (sType == 2) {
        reuseCellId = @"cell2";
        fixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        GFix *GF = self.tempArray[indexPath.row*2];
        GFix *GF2;
        if ((indexPath.row+1)*2>self.tempArray.count) {
            cell.mBgk2.hidden = YES;
        }else{
            GF2 = [self.tempArray objectAtIndex:indexPath.row*2+1];
            cell.mBgk2.hidden = NO;
        }
        
        
        cell.mName.text = GF.mClassName;
        cell.mPrice.text = [NSString stringWithFormat:@"%@¥",GF.mEstimatedPrice];
        cell.mDetail.text = GF.mDescribe;
        
        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:GF.mSmallImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
        cell.mName2.text = GF2.mClassName;
        cell.mPrice2.text = [NSString stringWithFormat:@"%@¥",GF2.mEstimatedPrice];
        cell.mDetail2.text = GF2.mDescribe;
        
        [cell.mImg2 sd_setImageWithURL:[NSURL URLWithString:GF2.mSmallImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
        [cell.mSelectBtn1 addTarget:self action:@selector(fooBtn1Touched:) forControlEvents:UIControlEventTouchUpInside];
        [cell.mSelectBtn2 addTarget:self action:@selector(fooBtn2Touched:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
        
    }else{
        reuseCellId = @"cell";
        FixNewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.mImg.image = mImageArr[indexPath.row];
        return cell;
    }

}
-(void)fooBtn1Touched:(UIButton *)sender
{
    fixTableViewCell *cell = (fixTableViewCell*)[sender findSuperViewWithClass:[fixTableViewCell class]];
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    GFix *GF = [self.tempArray objectAtIndex:index.row*2];
    
    comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
    
    
    ccc.mFixOrder = GFix.new;
    ccc.mFixOrder = GF;
    ccc.mSubClass = mSuperID;
    ccc.mID = GF.mId;
    [self presentModalViewController :ccc];

    
}
-(void)fooBtn2Touched:(UIButton *)sender
{

    
    fixTableViewCell *cell = (fixTableViewCell*)[sender findSuperViewWithClass:[fixTableViewCell class]];
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    GFix *GF = [self.tempArray objectAtIndex:index.row*2+1];
    
    comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
    
    
    ccc.mFixOrder = GFix.new;
    ccc.mFixOrder = GF;
    ccc.mSubClass = mSuperID;
    ccc.mID = GF.mId;
    [self presentModalViewController :ccc];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (sType == 2) {
        GFix *GF = self.tempArray[indexPath.row];
        
        comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
        
        
        ccc.mFixOrder = GFix.new;
        ccc.mFixOrder = GF;
        ccc.mSubClass = mSuperID;
        ccc.mID = GF.mId;
        [self presentModalViewController :ccc];
    }else{
    
        mFixViewController   *ppp = [[mFixViewController alloc] initWithNibName:@"mFixViewController" bundle:nil];
        ppp.sType = 2;
        ppp.mSuperID = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        ppp.mTT = mTTArr[indexPath.row];
        [self presentModalViewController:ppp];
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
- (void)leftBtnTouched:(id)sender{

    [self dismissViewController];
}

@end
