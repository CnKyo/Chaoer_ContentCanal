//
//  mTouzhiViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mTouzhiViewController.h"

@interface mTouzhiViewController ()<UITextFieldDelegate>

@end

@implementation mTouzhiViewController
{
    NSMutableArray *mTT;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"众筹活动";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1];
    
    self.mMainView.layer.masksToBounds = YES;
    self.mMainView.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.87 alpha:1].CGColor;
    self.mMainView.layer.borderWidth = 0.5;
    
    self.mNameTx.delegate = self.mMoneyTx.delegate = self;
    mTT = [NSMutableArray new];

    
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

- (IBAction)payTypeAction:(UIButton *)sender {
    
    [mTT removeAllObjects];
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                self.mBankBtn.selected = YES;
                self.mAliBtn.selected = NO;
                self.mwechatBtn.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                self.mBankBtn.selected = NO;
                self.mAliBtn.selected = YES;
                self.mwechatBtn.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
        }
            break;
        case 3:
        {
            if (sender.selected == NO) {
                self.mBankBtn.selected = NO;
                self.mAliBtn.selected = NO;
                self.mwechatBtn.selected = YES;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
            
        }
            break;
        default:
            break;
    }
    

    
}




@end
