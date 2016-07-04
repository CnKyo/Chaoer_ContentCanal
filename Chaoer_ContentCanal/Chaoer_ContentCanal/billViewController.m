//
//  billViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "billViewController.h"
#import "billView.h"
@interface billViewController ()

@end

@implementation billViewController
{
    UIScrollView *mScrollerView;
    billView *mView;
    
    NSMutableArray *mTypeArr;
    NSMutableArray *mNoteArr;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName = self.Title = @"发票信息";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
    mTypeArr = [NSMutableArray new];
    mNoteArr = [NSMutableArray new];
    
    [self initView];
    
}

- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    [mScrollerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.bottom.equalTo(self.view).offset(@65);
        make.width.offset(DEVICE_Width);
    }];
    
    mView = [billView shareView];
    mView.mTxViewH.constant = 10;
    mView.mBillTx.enabled = NO;
    [mView.mBillPersonBtn addTarget:self action:@selector(mTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBillUninBtn addTarget:self action:@selector(mTypeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mView.mBillDetailBTn addTarget:self action:@selector(mNoteAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBillConsumableBtn addTarget:self action:@selector(mNoteAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mBillOfficeBtn addTarget:self action:@selector(mNoteAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mBillPcBtn addTarget:self action:@selector(mNoteAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mScrollerView addSubview:mView];
    [mView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(mScrollerView).offset(@0);
        make.height.offset(@458);
        make.width.offset(DEVICE_Width);
    }];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 458);
    
    UIButton *mSubmitBtn = [UIButton new];
    mSubmitBtn.backgroundColor = M_CO;
    [mSubmitBtn setTitle:@"确定" forState:0];
    
    mSubmitBtn.layer.masksToBounds = YES;
    mSubmitBtn.layer.cornerRadius = 3;
    
    [mSubmitBtn addTarget:self action:@selector(mSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mSubmitBtn];
    
    [mSubmitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(@15);
        make.right.equalTo(self.view).offset(@-15);
        make.bottom.equalTo(self.view).offset(@-15);
        make.height.offset(@40);
    }];
    
    
}

- (void)mTypeAction:(UIButton *)sender{
    [mTypeArr removeAllObjects];

    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.mBillPersonBtn.selected = YES;
                mView.mBillUninBtn.selected = NO;
                [mTypeArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mTypeArr removeObject:NumberWithFloat(sender.tag)];
                
            }
            mView.mBillTx.enabled = NO;
            mView.mBillTx.placeholder = @"个人发票没有抬头！";
            mView.mTxViewH.constant = 10;

        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.mBillPersonBtn.selected = NO;
                mView.mBillUninBtn.selected = YES;
                [mTypeArr addObject:NumberWithFloat(sender.tag)];
                mView.mBillTx.enabled = YES;
                mView.mBillTx.placeholder = @"请输入发票抬头";
                mView.mTxViewH.constant = 50;


            }else{
                sender.selected = NO;
                [mTypeArr removeObject:NumberWithFloat(sender.tag)];
                mView.mBillTx.enabled = NO;
                mView.mTxViewH.constant = 10;

            }


        }
            break;
            
        default:
            break;
    }
    
}

- (void)mNoteAction:(UIButton *)sender{
    [mNoteArr removeAllObjects];

    switch (sender.tag) {
        case 11:
        {
            if (sender.selected == NO) {
                mView.mBillDetailBTn.selected = YES;

                mView.mBillConsumableBtn.selected = NO;
                mView.mBillOfficeBtn.selected = NO;

                mView.mBillPcBtn.selected = NO;

                [mNoteArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mNoteArr removeObject:NumberWithFloat(sender.tag)];
            }
        }
            break;
        case 12:
        {
            if (sender.selected == NO) {
                mView.mBillDetailBTn.selected = NO;
                
                mView.mBillConsumableBtn.selected = YES;
                mView.mBillOfficeBtn.selected = NO;
                
                mView.mBillPcBtn.selected = NO;
                
                [mNoteArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mNoteArr removeObject:NumberWithFloat(sender.tag)];
            }
        }
            break;
        case 13:
        {
            if (sender.selected == NO) {
                mView.mBillDetailBTn.selected = NO;
                
                mView.mBillConsumableBtn.selected = NO;
                mView.mBillOfficeBtn.selected = YES;
                
                mView.mBillPcBtn.selected = NO;
                
                [mNoteArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mNoteArr removeObject:NumberWithFloat(sender.tag)];
            }
        }
            break;
        case 14:
        {
            if (sender.selected == NO) {
                mView.mBillDetailBTn.selected = NO;
                
                mView.mBillConsumableBtn.selected = NO;
                mView.mBillOfficeBtn.selected = NO;
                
                mView.mBillPcBtn.selected = YES;
                
                [mNoteArr addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mNoteArr removeObject:NumberWithFloat(sender.tag)];
            }
        }
            break;
        default:
            break;
    }
}
- (void)mSubmitAction:(UIButton *)sender{

    MLLog(@"%@%@",mTypeArr,mNoteArr);
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
