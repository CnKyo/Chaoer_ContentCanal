//
//  myTagViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "myTagViewController.h"

@interface myTagViewController ()

@end

@implementation myTagViewController

{
    UIScrollView *mView;
}

- (void)viewWillAppear:(BOOL)animated{

    
    [super viewWillAppear:animated];
    
    [self loadData];
    
}


- (void)loadData{

    [self showWithStatus:@"正在加载...."];
    [[GPPTer backPPTUser] getMyTags:^(mBaseData *resb, NSArray *mArr) {
        
        [self removeEmptyView];
        
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
                
                [self initView];
            }
            
            
            
        }else{
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的标签";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;

    
    mView = [UIScrollView new];
    mView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mView];
    
    [self loadData];
}
- (void)initView{

    
    NSMutableArray *mTT = [NSMutableArray new];
    
    for (GPPTMyTag *mTag in self.tempArray) {
        [mTT addObject:[NSString stringWithFormat:@"%@(%d)",mTag.mTagName,mTag.mTagNum]];
    }
    
    for (UILabel *lb in mView.subviews) {
        [lb removeFromSuperview];
    }
    
    CGFloat mXX = 10;
    CGFloat mYY = 10;
    
    for (int i = 0; i<mTT.count; i++) {
        CGFloat mWW = [Util labelTextWithWidth:mTT[i]]+15;
        
        
        UILabel *lll = [UILabel new];
        
        lll.frame = CGRectMake(mXX, mYY, mWW, 25);
        
        lll.textColor = [UIColor whiteColor];
        lll.text = mTT[i];
        lll.backgroundColor = [UIColor colorWithRed:0.60 green:0.78 blue:0.96 alpha:1.00];
        lll.font = [UIFont systemFontOfSize:13];
        lll.textAlignment = NSTextAlignmentCenter;
        lll.layer.masksToBounds = YES;
        lll.layer.cornerRadius = 10;
        [mView addSubview:lll];
        
        mXX += mWW+20;
        
        
        if (mXX >= DEVICE_Width-mWW+20) {
            mXX = 10;
            mYY += 40;

        }
        
        
        
    }
    
    mView.contentSize = CGSizeMake(DEVICE_Width, mYY);
    
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
