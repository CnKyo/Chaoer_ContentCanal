//
//  mCookDetail.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCookDetail.h"

#import "mCookDetailView.h"

@interface mCookDetail ()

@end

@implementation mCookDetail
{

    mCookDetailView *mView;
    
    UIScrollView *mScrollerView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Title = self.mPageName = self.mTT;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    [self initView];
}

- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    
    mScrollerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:mScrollerView];
    
    
    CGFloat h1 = [Util labelText:self.mFood fontSize:14 labelWidth:mView.mFood.mwidth];
    
    CGFloat h2 = [Util labelText:self.mDesctipution fontSize:14 labelWidth:mView.mDesctription.mwidth];
    
    
    CGFloat tt = 568;
    
    if (tt<=568) {
        
        tt = 568;
        
    }else{
    
        tt = 568+h1+h2-32;
    }
    
    
    
    mView = [mCookDetailView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, tt);
    
    [mView.mImg sd_setImageWithURL:[NSURL URLWithString:self.mImg] placeholderImage:nil];
    mView.mName.text = self.mName;
    mView.mFood.text = self.mFood;
    mView.mDesctription.text = self.mDesctipution;
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, tt);
    
    
    
    
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
