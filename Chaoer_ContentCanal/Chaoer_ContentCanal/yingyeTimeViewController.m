//
//  yingyeTimeViewController.m
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "yingyeTimeViewController.h"

@interface yingyeTimeViewController ()

@end

@implementation yingyeTimeViewController
{

    UIScrollView    *ssss;
    
    UIView *mHeaderView;
    
    UIView  *mMainView;
    
    NSMutableArray  *mWeekArr;
    NSMutableArray  *mTimeArr;
    
    
    NSMutableArray  *weekArr;
    NSMutableArray  *hourArr;

    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    
    self.mPageName = self.Title = @"营业时间";
    self.hiddenRightBtn = NO;
    self.rightBtnTitle = @"保存";


    ssss = [UIScrollView new];
    ssss.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1];
    [self.view addSubview:ssss];
    
    [ssss makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(0);

    }];
    
    mWeekArr = [NSMutableArray new];
    mTimeArr = [NSMutableArray new];
    
    weekArr = [NSMutableArray new];
    hourArr = [NSMutableArray new];

    
    [self initView];
    
}
- (void)initView{
    
    mHeaderView = [UIView new];
    mHeaderView.backgroundColor = [UIColor whiteColor];
    
    mHeaderView.layer.masksToBounds = YES;
    mHeaderView.layer.borderColor = [UIColor colorWithRed:0.925 green:0.922 blue:0.918 alpha:1].CGColor;
    mHeaderView.layer.borderWidth = 0.5;
    [ssss addSubview:mHeaderView];
    
    mMainView = [UIView new];
    mMainView.backgroundColor = [UIColor whiteColor];
    
    mMainView.layer.masksToBounds = YES;
    mMainView.layer.borderColor = [UIColor colorWithRed:0.925 green:0.922 blue:0.918 alpha:1].CGColor;
    mMainView.layer.borderWidth = 0.5;
    [ssss addSubview:mMainView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ssss).offset(0);
        make.right.equalTo(ssss).offset(0);
        make.top.equalTo(ssss).offset(0);
        make.bottom.equalTo(mMainView.top).offset(-20);
        make.width.equalTo(ssss.width);
        make.height.offset(80);

    }];
    

    NSArray *week = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    for (int i = 0; i<week.count; i++) {
                
        UIButton *bbb = [UIButton new];
        bbb.frame = CGRectMake(5+i*DEVICE_Width/7-5, 20, 45, 45);
        bbb.layer.masksToBounds = YES;
        bbb.layer.cornerRadius = bbb.mwidth/2;

        [bbb setTitleColor:[UIColor colorWithRed:0.353 green:0.353 blue:0.353 alpha:1] forState:UIControlStateNormal];
        [bbb setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [bbb setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [bbb setBackgroundImage:[UIImage imageNamed:@"weekBtn_selected"] forState:UIControlStateSelected];
        
        [bbb setTitle:week[i] forState:0];
        bbb.tag = i+1;
        [bbb addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [mHeaderView addSubview:bbb];
        
        
        for (int j = 0; j<_mWeek.count; j++) {
            NSString *ss = [NSString stringWithFormat:@"%d",i+1];
            if ([ss isEqualToString:_mWeek[j]]) {
                bbb.selected = YES;
                [weekArr addObject:ss];
            }
        }
    }
    
    NSArray *hour = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"];
    
    MLLog(@"穿过来的时间是：%@",_mHour);
    
    int x = 10;
    int y = 10;
    
    
    for (int j = 0; j<hour.count; j++) {
        UIButton *ccc = [UIButton new];
        ccc.frame = CGRectMake(x, y, DEVICE_Width/4-20, 40);
        ccc.layer.masksToBounds = YES;
        ccc.layer.cornerRadius = 5;
        
        [ccc setTitleColor:[UIColor colorWithRed:0.353 green:0.353 blue:0.353 alpha:1] forState:UIControlStateNormal];
        [ccc setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [ccc setBackgroundImage:[UIImage imageNamed:@"hourBtn_normal"] forState:UIControlStateNormal];
        [ccc setBackgroundImage:[UIImage imageNamed:@"hourBtn_selected"] forState:UIControlStateSelected];
        
        [ccc setTitle:hour[j] forState:0];
        ccc.tag = j;
        [ccc addTarget:self action:@selector(cccAction:) forControlEvents:UIControlEventTouchUpInside];
        [mMainView addSubview:ccc];
        
        for (int i = 0; i<_mHour.count; i++) {
            NSString *ss = hour[j];
            if ([ss isEqualToString:_mHour[i]]) {
                ccc.selected = YES;
                [hourArr addObject:ss];
            }
        }
        
        x+=DEVICE_Width/4;
        if (x>=DEVICE_Width) {
            y+=50;
            x=10;
        }

    }
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ssss).offset(0);
        make.right.equalTo(ssss).offset(0);
        make.top.equalTo(mHeaderView.bottom).offset(20);
        make.bottom.equalTo(ssss).offset(0);
        make.width.equalTo(ssss.width);
        make.height.offset(y);
    }];

}

#pragma mark----周选择
- (void)btnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ( sender.selected ) {
        [weekArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }else{
        [weekArr removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    
}

#pragma mark----时间选择
- (void)cccAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ( sender.selected ) {
        [hourArr addObject:sender.titleLabel.text];
    }else{
        [hourArr removeObject:sender.titleLabel.text];
    }
    
}
- (void)rightBtnTouched:(id)sender{
    
    MLLog(@"最后组装的数据时：%@--%@",weekArr,hourArr);
    
//    [_mShop updateBusinessTime:weekArr andHourArr:hourArr block:^(SResBase *info) {
//        if (info.msuccess) {
//            if (_itblock) {
//                _itblock(_mShop);
//            }
//            
//
//            [self popViewController];
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:info.mmsg];
//        }
//    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
