//
//  SellerDetaillVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "SellerDetaillVC.h"

@interface SellerDetaillVC ()

@end

@implementation SellerDetaillVC

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.mPageName = @"预览";
    
    self.Title = self.mPageName;
    
    if (_mType == 1) {
        
        _mServiceTimeHeight.constant = 0;
        
        NSString *string = @"";
//        for (SNorms *s in _mGoods.mNorms) {
//            string = [string stringByAppendingString:[NSString stringWithFormat:@" %@",s.mName]];
//        }
//        _mGuige.text = string;
//        _mTypeName.text = @"商品详情";
        
    }else{
    
        _mGuigeHeight.constant = 0;
        _mTypeName.text = @"服务详情";
    }
    
//    if (_mGoods.mImgs.count >0) {
//        _mImg.image = [_mGoods.mImgs objectAtIndex:0];
//    }
//    _mName.text = _mGoods.mName;
//    _mPrice.text = [NSString stringWithFormat:@"¥%.2f",_mGoods.mPrice];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _mDianpu.text = [defaults objectForKey:@"shopname"];
    
    NSDate *date = [NSDate date];
    
    NSTimeInterval time = [date timeIntervalSince1970]-3600*7;
    
    
    
    _mServiceTime.text = [Util getTimeStringNoYear:[Util dateWithInt:time]];
    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_mGoods.mBrief dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    _mRemark.attributedText = attrStr;

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

- (IBAction)mOutClick:(id)sender {
    
     [self popViewController];
}
@end
