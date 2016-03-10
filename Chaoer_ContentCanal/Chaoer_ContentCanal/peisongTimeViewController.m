//
//  peisongTimeViewController.m
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "peisongTimeViewController.h"
#import "peisongView.h"
@interface peisongTimeViewController ()<HZQDatePickerViewDelegate>

@end

@implementation peisongTimeViewController
{

    peisongView *mAddView;
    peisongView *mJianView;
    
    int     x;
    
    NSMutableArray *ArrWithView;
    
    HZQDatePickerView *_pikerView;
    
    NSMutableArray  *mStartArr;
    NSMutableArray  *mEndArr;
    
    peisongView *tempView;


}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    
    self.mPageName = self.Title = @"配送时间";
    self.hiddenRightBtn = NO;
    self.rightBtnTitle = @"保存";
    
    ArrWithView = [NSMutableArray new];
    mStartArr = [NSMutableArray new];
    mEndArr = [NSMutableArray new];

    [self initView];
}
- (void)initView{

    mAddView = [peisongView shareView];
    mAddView.frame = CGRectMake(0, 84, DEVICE_Width, 60);
    [mAddView.mAddBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [mAddView.mSeconTimeBtn addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    [mAddView.mFirstTimeBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mAddView];
    mAddView.tag = 11;
//    [ArrWithView addObject:mAddView];
    x = mAddView.mbottom;

}
#pragma mark----开始时间
- (void)startAction:(UIButton *)sender{
    
    tempView = (peisongView *)sender.superview;
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = DateTypeOfStart;
//    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];

}
#pragma mark----结束时间
- (void)endAction:(UIButton *)sender{
    
    tempView = (peisongView *)sender.superview;
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = DateTypeOfEnd;
//    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
}
#pragma mark----添加
- (void)addAction:(UIButton *)sender{
    if (ArrWithView.count >= 2) {
        return;
    }
    mJianView = [peisongView shareJianView];
    mJianView.frame = CGRectMake(0, x, DEVICE_Width, 60);
    [mJianView.mJianBtn addTarget:self action:@selector(jianAction:) forControlEvents:UIControlEventTouchUpInside];
    [mJianView.mSeconTimeBtn addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    [mJianView.mFirstTimeBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:mJianView];
    
    [ArrWithView addObject:mJianView];
    x+=60;

    
}
#pragma mark----删除
- (void)jianAction:(UIButton *)sender{
    
    [ArrWithView removeObject:sender.superview];
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[peisongView class]]) {
            if (v.tag!=11) {
                [v removeFromSuperview];

            }
        }
    }
    
    for (int i = 0;i<ArrWithView.count;i++ ) {
        
        peisongView *p = [ArrWithView objectAtIndex:i];
        p.frame = CGRectMake(0, i*60+mAddView.mbottom, DEVICE_Width, 60);
        [self.view addSubview:p];
    }
    
    [sender.superview removeFromSuperview];

    
    x-=60;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);

    switch (type) {
        case DateTypeOfStart:
        {
            MLLog(@"开始时间 :%@",date);
            [tempView.mFirstTimeBtn setTitle:date forState:0];
            
        }
            
            break;
            
        case DateTypeOfEnd:
        {
            MLLog(@"结束时间 :%@",date);
            [tempView.mSeconTimeBtn setTitle:date forState:0];



        }
            break;
            
        default:
            break;
    }
}
- (void)rightBtnTouched:(id)sender{
    
    [mStartArr removeAllObjects];
    [mEndArr removeAllObjects];
    
    [mStartArr addObject:mAddView.mFirstTimeBtn.titleLabel.text];
    [mEndArr addObject:mAddView.mSeconTimeBtn.titleLabel.text];
    
    for (peisongView *mview in ArrWithView) {
        
        [mStartArr addObject:mview.mFirstTimeBtn.titleLabel.text];
        [mEndArr addObject:mview.mSeconTimeBtn.titleLabel.text];

        
    }
    if (mStartArr.count != mEndArr.count) {
        [SVProgressHUD showErrorWithStatus:@"时间设置无效!"];
        return;
    }
    if (mStartArr.count == 0 || mEndArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"时间设置无效!"];
        return;
    }
    
    for (int i = 0; i<mStartArr.count; i++) {

        if ([mStartArr[i] isEqualToString:@"00:00"] || [mEndArr[i] isEqualToString:@"00:00"]) {
            [SVProgressHUD showErrorWithStatus:@"时间设置无效!"];
            return;
        }
    }
    
    MLLog(@"最后的数据是：－－－－开始时间：/n%@-----－－－－结束时间/n%@",mStartArr,mEndArr);
    if (mStartArr.count != ArrWithView.count+1 || mEndArr.count != ArrWithView.count+1) {
        [SVProgressHUD showErrorWithStatus:@"时间设置无效!"];
        return;
    }
    if (mStartArr.count != mEndArr.count) {
        [SVProgressHUD showErrorWithStatus:@"时间设置无效!"];
        return;
    }

    if (mStartArr.count >1 && mEndArr.count > 1) {
        if (mStartArr.count == 2) {
            for (int i = 1; i<mStartArr.count; i++) {
                
                if ([Util DateToInt:mStartArr[i]] > [Util DateToInt:[mStartArr firstObject]] || [Util DateToInt:mStartArr[i]] > [Util DateToInt:[mEndArr firstObject]] ) {
                    
                }
                else{
                    [SVProgressHUD showErrorWithStatus:@"设置时间重复！"];
                    return;
                }
            }
        }
        if (mStartArr.count == 3) {
            
                
                if (([Util DateToInt:mStartArr[2]] > [Util DateToInt:mStartArr[1]] || [Util DateToInt:mStartArr[2]] > [Util DateToInt:mEndArr[1]]) && ([Util DateToInt:mStartArr[1]] > [Util DateToInt:[mStartArr firstObject]] || [Util DateToInt:mStartArr[1]] > [Util DateToInt:[mEndArr firstObject]]) ) {
                    
                }
                else{
                    [SVProgressHUD showErrorWithStatus:@"设置时间重复！"];
                    return;
                }
            
        }
   
    }
    

  
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:mStartArr forKey:@"stimes"];
    [dic setObject:mEndArr forKey:@"etimes"];
    
    [_mShop updateDeliveryTimes:dic block:^(SResBase *info) {
        if (info.msuccess) {
            if (_itblock) {
                _itblock(dic);
            }
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];
    

}
@end
