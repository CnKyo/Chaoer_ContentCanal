//
//  noteOrmessageViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "noteOrmessageViewController.h"


#import "WKLabelView.h"
#import "mMessageOrNoteView.h"
@interface noteOrmessageViewController ()<ViewWithBgViewDidSelectedDelegate>

@end

@implementation noteOrmessageViewController
{

    UIScrollView *mScrollerView;
    
    WKLabelView *mBtnView;
    
    mMessageOrNoteView *mBottomView;
    
}
- (void)viewDidLoad {
    
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName = self.Title = @"备注留言";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    [self initView];
}


- (void)initView{

    
    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    [self.view addSubview:mScrollerView];
    
    
    UILabel *lll = [UILabel new];
    lll.frame = CGRectMake(10, 10, DEVICE_Width, 25);
    lll.text = @"选择标签";
    lll.textColor = [UIColor lightGrayColor];
    lll.font = [UIFont systemFontOfSize:15];
    [mScrollerView addSubview:lll];
    
    mBtnView=[[WKLabelView alloc]init];
    
    [mBtnView setArray:nil];
    mBtnView.delegate = self;
    mBtnView.backgroundColor=[UIColor whiteColor];
    
    CGRect mRR = lll.frame;
    mRR.size.height = mBtnView.mHight;
    mRR.origin.y = lll.mbottom+10;
    mRR.origin.x = 0;
    mBtnView.frame = mRR;
    
    [mScrollerView addSubview:mBtnView];
    

    
    mBottomView = [mMessageOrNoteView shareView];
    mBottomView.frame = CGRectMake(0, mBtnView.mbottom+10, DEVICE_Width, 200);
    [mScrollerView addSubview:mBottomView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, mBottomView.frame.origin.y+mBottomView.mheight+30);
    
}
- (void)viewDidSelectedIndex:(NSInteger)mIndex{
    
    MLLog(@"－＋－＋－＋：%ld",(long)mIndex);
}
- (void)currentViewArray:(NSArray *)mArr{
    MLLog(@"－＋－＋－＋：%@",mArr);
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
