//
//  changeNameViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/21.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "changeNameViewController.h"

@interface changeNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mTx;

@property (weak, nonatomic) IBOutlet UIButton *mOkbtn;
@property (weak, nonatomic) IBOutlet UIView *mBgkView;

@end

@implementation changeNameViewController

- (IBAction)mOkbtn:(id)sender {
    if (self.mTx.text.length < 4 || self.mTx.text.length >20) {
        MLLog(@"1");
    }if (self.mTx.text == nil || [self.mTx.text isEqualToString:@""]) {
        
    }else{
    
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.Title = self.mPageName = @"修改昵称";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.view.backgroundColor = M_BGCO;
    self.mTx.delegate = self;
    self.mTx.clearButtonMode = UITextFieldViewModeUnlessEditing;

    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = M_TextColor2.CGColor;
    self.mBgkView.layer.borderWidth = 0.5;
    self.mBgkView.layer.cornerRadius = 4;
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tapAction];
}
#pragma  mark -----键盘消失
- (void)tapAction{
    
    [self.mTx resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



///限制密码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==20)
    {
        res= PASS_LENGHT-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

@end
