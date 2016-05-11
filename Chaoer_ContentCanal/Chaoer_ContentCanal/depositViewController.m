//
//  depositViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "depositViewController.h"
#import "pptStatusViewController.h"
@interface depositViewController ()
@property (weak, nonatomic) IBOutlet UIView *mView;
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@end

@implementation depositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"申请跑跑腿";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    
    self.mView.layer.masksToBounds = YES;
    self.mView.layer.cornerRadius = self.mView.mwidth/2;
    
    self.mOkBtn.layer.masksToBounds = YES;
    self.mOkBtn.layer.cornerRadius = 3;
    
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
- (IBAction)mOkAction:(id)sender {
    
    pptStatusViewController *ppp = [[pptStatusViewController alloc] initWithNibName:@"pptStatusViewController" bundle:nil];
    [self pushViewController:ppp];
    
}




@end
