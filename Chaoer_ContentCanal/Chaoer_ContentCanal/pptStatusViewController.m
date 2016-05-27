//
//  pptStatusViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptStatusViewController.h"

@interface pptStatusViewController ()

@end

@implementation pptStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"申请成功";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenBackBtn = YES;
    
    self.mBtn.layer.masksToBounds = YES;
    self.mBtn.layer.cornerRadius = 3;
    self.mBtn.layer.borderColor = M_CO.CGColor;
    self.mBtn.layer.borderWidth = 0.5;
    

}
- (IBAction)btnAction:(UIButton *)sender {
    
    [self popViewController_2];
    
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
