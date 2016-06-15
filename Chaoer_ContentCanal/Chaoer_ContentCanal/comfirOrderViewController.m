//
//  comfirOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "comfirOrderViewController.h"
#import "mComfirOrderDetailView.h"


#import "goOrderViewController.h"


@interface comfirOrderViewController ()

@end

@implementation comfirOrderViewController
{

    UIScrollView *mScrollerView;
    mComfirOrderDetailView *mView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"服务详情";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    
    UIButton *mCommitBtn = [UIButton new];
    mCommitBtn.frame = CGRectMake(0, DEVICE_Height-40, DEVICE_Width, 40);
    mCommitBtn.backgroundColor = M_CO;
    [mCommitBtn setTitle:@"立即下单" forState:0];
    [mCommitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [mCommitBtn addTarget:self action:@selector(mCommitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommitBtn];
    

    [self initView];
    
}
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-104);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [mComfirOrderDetailView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    mView.mName.text = self.mFixOrder.mClassName;
    mView.mPrice.text = [NSString stringWithFormat:@"%@¥",self.mFixOrder.mEstimatedPrice];
    mView.mDetail.text = self.mFixOrder.mDescribe;
    [mView.mBigImg sd_setImageWithURL:[NSURL URLWithString:self.mFixOrder.mBigImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 276+[Util labelText:self.mFixOrder.mDescribe fontSize:14 labelWidth:mView.mDetail.mwidth]);
    

    
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

#pragma mark---－确认下单
- (void)mCommitAction:(UIButton *)sender{

    
    goOrderViewController *ccc = [[goOrderViewController alloc] initWithNibName:@"goOrderViewController" bundle:nil];
    ccc.mFixOrder = GFix.new;
    ccc.mFixOrder = self.mFixOrder;
    ccc.mSubClass = self.mSubClass;
    ccc.mID = self.mID;
    [self presentModalViewController :ccc];
    
    
}

- (void)leftBtnTouched:(id)sender{
    [self dismissViewController];
}
@end
