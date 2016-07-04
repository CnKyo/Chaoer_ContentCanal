//
//  choiseServicerViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiseServicerViewController.h"
#import "choiseServicerTableViewCell.h"
#import "DLStarRatingControl.h"
#import "TQStarRatingView.h"

#import "choiceServicerViewController.h"

#import "makeServiceViewController.h"
@interface choiseServicerViewController ()<UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate>

@end

@implementation choiseServicerViewController
{

    UITableView *mTableView;
    
    /**
     *  起始页1最后10
     */
    int mStart;
    
    int mEnd;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"确认订单";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mStart = 1;
    mEnd = 10;
    
    self.page = 1;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    [self initview];
}

- (void)initview{
    
    UIImageView *iii = [UIImageView new];

    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    [self loadTableView:CGRectMake(0, 79, DEVICE_Width, DEVICE_Height-79) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"choiseServicerTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
}
- (void)headerBeganRefresh{
    self.page = 1;
//    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    NSString *address = nil;
    
    if (_Type == 1) {
        address = [self.mData.mData objectForKey:@"address"];
        
        [mUserInfo getServiceName:self.mAddress andLng:nil andLat:nil andOneLevel:self.mSubClass andTwoLevel:[NSString stringWithFormat:@"%d",self.mID]  andPage:self.page andEnd:10 block:^(mBaseData *resb, GServiceList *mList) {
            [self headerEndRefresh];
            [self.tempArray removeAllObjects];
            [self removeEmptyView];
            if (resb.mSucess) {
                
                if (mList.mArray.count<=0) {
                    [self addEmptyViewWithImg:nil];
                }else{
                    [self.tempArray addObjectsFromArray:mList.mArray];
                    
                    [self.tableView reloadData];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];

            }
        }];

    }else{
    
        address = self.mFix.mAddress;
        
        [mUserInfo getServiceName:address andLng:nil andLat:nil andOneLevel:self.mFix.mClassificationName andTwoLevel:self.mFix.mClassificationName2 andPage:self.page andEnd:10 block:^(mBaseData *resb, GServiceList *mList) {
            [self headerEndRefresh];
            [self.tempArray removeAllObjects];
            [self removeEmptyView];

            if (resb.mSucess) {
                
//                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                if (mList.mArray.count<=0) {
                    [self addEmptyViewWithImg:nil];
                }else{
                    [self.tempArray addObjectsFromArray:mList.mArray];
                    
                    [self.tableView reloadData];
                }
                

            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];

            }
        }];

    }
    
    
    
   
}
- (void)footetBeganRefresh{
    
    self.page ++;
    
    NSString *address = nil;
//    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    if (_Type == 1) {
        
        address = [self.mData.mData objectForKey:@"address"];

        [mUserInfo getServiceName:address andLng:nil andLat:nil andOneLevel:[self.mData.mData objectForKey:@"classification1"] andTwoLevel:[self.mData.mData objectForKey:@"classification2"] andPage:self.page andEnd:10 block:^(mBaseData *resb, GServiceList *mList) {
            [self footetEndRefresh];
            [self removeEmptyView];

            if (resb.mSucess) {
                
//                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                if (mList.mArray.count<=0) {
                    [self addEmptyViewWithImg:nil];
                }else{
                    [self.tempArray addObjectsFromArray:mList.mArray];
                    mStart = mList.pageNumber+10;
                    mEnd = mList.pageSize+10;
                    [self.tableView reloadData];
                }
   
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];

            }
        }];

    }else{
        address = self.mFix.mAddress;

        [mUserInfo getServiceName:address andLng:nil andLat:nil andOneLevel:self.mFix.mClassificationName andTwoLevel:self.mFix.mClassificationName2 andPage:self.page andEnd:10 block:^(mBaseData *resb, GServiceList *mList) {
            [self footetEndRefresh];
            [self removeEmptyView];

            if (resb.mSucess) {
                
//                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                if (mList.mArray.count<=0) {
                    [self addEmptyViewWithImg:nil];
                }else{
                    [self.tempArray addObjectsFromArray:mList.mArray];
                    mStart = mList.pageNumber+10;
                    mEnd = mList.pageSize+10;
                    [self.tableView reloadData];
                }

            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];

            }
        }];

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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    SServicer *ss = self.tempArray[indexPath.row];
    
    choiseServicerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mName.text = ss.mMerchantName;
    cell.mDistance.text  = ss.mDistance;
    cell.mPhone.text = ss.mMerchantPhone;
    

    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],ss.mMerchantImage]] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    int x = ss.mPraiseRate;
    cell.mRaitingView.numberOfStars = 5;
    cell.mRaitingView.scorePercent = x/10;
    cell.mRaitingView.allowIncompleteStar = YES;
    cell.mRaitingView.hasAnimation = YES;
    
    cell.mDoneBtn.tag = ss.mId;
    
//    [cell.mDoneBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    SServicer *ss = self.tempArray[indexPath.row];

//    choiceServicerViewController *sss = [choiceServicerViewController new];
//    sss.mS = SServicer.new;
//    sss.mS = ss;
//    [self pushViewController:sss];


    self.block([NSString stringWithFormat:@"%@",ss.mMerchantName],[NSString stringWithFormat:@"%d",ss.mId]);
    
    [self dismissViewController];

}
#pragma mark----预约按钮
- (void)makeAction:(UIButton *)sender{
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo getFixOrderComfirm:[[NSString stringWithFormat:@"%@",[self.mData.mData objectForKey:@"orderId"]] intValue] andmId:[[NSString stringWithFormat:@"%ld",(long)sender.tag] intValue] block:^(mBaseData *resb, GFixOrder *mOrder) {

        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            makeServiceViewController *mmm = [[makeServiceViewController alloc] initWithNibName:@"makeServiceViewController" bundle:nil];
            mmm.mOrder = GFixOrder.new;
            mmm.mOrder = mOrder;
            mmm.mOrderId = [[NSString stringWithFormat:@"%@",[self.mData.mData objectForKey:@"orderId"]] intValue];
            mmm.mId = [[NSString stringWithFormat:@"%ld",(long)sender.tag] intValue];
            [self presentViewController:mmm animated:YES completion:nil];

        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];
    
    
    
    

    
}

- (void)leftBtnTouched:(id)sender{

    if (_Type == 1) {
//        [self AlertViewShow:@"保修订单已经生成确定要离开此页面吗？" alertViewMsg:@"保修订单可以订单列表里查看！" alertViewCancelBtnTiele:@"取消" alertTag:10];

        [self dismissViewController];
    }else{
        [self popViewController];
    }
  
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        [self dismissViewController_2];
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"离开", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}


@end
